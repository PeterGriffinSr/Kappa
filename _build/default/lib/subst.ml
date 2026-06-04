open Types
module IntMap = Map.Make (Int)

type t = Types.t IntMap.t

let empty : t = IntMap.empty

let rec apply s = function
  | TVar v -> (
      match IntMap.find_opt v s with Some typ -> apply s typ | None -> TVar v)
  | TProd (t1, t2) -> TProd (apply s t1, apply s t2)
  | TArrow (t1, t2) -> TArrow (apply s t1, apply s t2)
  | other -> other

let compose s1 s2 =
  let merged = IntMap.map (fun typ -> apply s1 typ) s2 in
  IntMap.union (fun _ _ v2 -> Some v2) s1 merged

let rec occurs_check v = function
  | TVar v' -> v = v'
  | TProd (t1, t2) | TArrow (t1, t2) -> occurs_check v t1 || occurs_check v t2
  | _ -> false

let rec unify t1 t2 =
  match (t1, t2) with
  | TVar v1, TVar v2 when v1 = v2 -> empty
  | TVar v, typ | typ, TVar v ->
      if occurs_check v typ then
        failwith
          "Type Error: Infinite type constraint detected (Occurs Check \
           Failure)."
      else IntMap.singleton v typ
  | TInt, TInt | TBool, TBool | TString, TString | TUnit, TUnit -> empty
  | TProd (l1, r1), TProd (l2, r2) ->
      let s1 = unify l1 l2 in
      let s2 = unify (apply s1 r1) (apply s1 r2) in
      compose s2 s1
  | TArrow (i1, o1), TArrow (i2, o2) ->
      let s1 = unify i1 i2 in
      let s2 = unify (apply s1 o1) (apply s1 o2) in
      compose s2 s1
  | TRowExtend (tag1, val1, tail1), TRowExtend (tag2, val2, tail2) ->
      if tag1 = tag2 then
        let s1 = unify val1 val2 in
        let s2 = unify (apply s1 tail1) (apply s1 tail2) in
        compose s2 s1
      else
        let beta = Types.next_var () in
        let s1 = unify tail1 (TRowExtend (tag2, val2, beta)) in
        let s2 =
          unify (apply s1 tail2) (apply s1 (TRowExtend (tag1, val1, beta)))
        in
        compose s2 s1
  | a, b ->
      failwith
        (Printf.sprintf
           "Type Error: Cannot unify structural mismatch between %s and %s."
           (Types.to_string a) (Types.to_string b))
