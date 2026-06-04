open Types
module Env = Map.Make (String)

type env = Scheme.t Env.t

let infer_prim = function
  | Graph.Id ->
      let a = Types.next_var () in
      TArrow (a, a)
  | Graph.Fst ->
      let a = Types.next_var () in
      let b = Types.next_var () in
      TArrow (TProd (a, b), a)
  | Graph.Snd ->
      let a = Types.next_var () in
      let b = Types.next_var () in
      TArrow (TProd (a, b), b)
  | Graph.Add -> TArrow (TProd (TInt, TInt), TInt)
  | Graph.Sub -> TArrow (TProd (TInt, TInt), TInt)
  | Graph.Mul -> TArrow (TProd (TInt, TInt), TInt)
  | Graph.Div -> TArrow (TProd (TInt, TInt), TInt)
  | Graph.Eq -> TArrow (TProd (TInt, TInt), TBool)

let rec infer_pattern = function
  | Graph.PatInt _ -> (Env.empty, Types.TInt)
  | Graph.PatBool _ -> (Env.empty, Types.TBool)
  | Graph.PatString _ -> (Env.empty, Types.TString)
  | Graph.PatIdent id ->
      let fresh_in = Types.next_var () in
      let fresh_out = Types.next_var () in
      let wire_typ = Types.TArrow (fresh_in, fresh_out) in
      let local_env = Env.singleton id ([], wire_typ) in
      (local_env, fresh_out)
  | Graph.PatTuple (p1, p2) ->
      let env1, t1 = infer_pattern p1 in
      let env2, t2 = infer_pattern p2 in
      let merged_env =
        Env.union
          (fun name _ _ ->
            failwith
              (Printf.sprintf
                 "Type Error: Variable %s bound multiple times in same pattern."
                 name))
          env1 env2
      in
      (merged_env, Types.TProd (t1, t2))
  | Graph.PatTag (tag, inner_pat) ->
      let local_env, inner_typ = infer_pattern inner_pat in
      let row_tail = Types.next_var () in
      (local_env, Types.TRowExtend (tag, inner_typ, row_tail))
  | Graph.PatWildcard -> (Env.empty, Types.next_var ())

let rec infer_node ctx node =
  match node with
  | Graph.Prim p -> (Subst.empty, infer_prim p)
  | Graph.Constant s ->
      let guess =
        if String.length s >= 2 && s.[0] = '"' then TString else TInt
      in
      (Subst.empty, TArrow (Types.next_var (), guess))
  | Graph.Var name -> (
      match Env.find_opt name ctx with
      | Some scheme -> (Subst.empty, Scheme.instantiate scheme)
      | None ->
          failwith
            (Printf.sprintf
               "Type Error: Symbol %s is not defined in this scope." name))
  | Graph.Compose (e1, e2) ->
      let s1, t1 = infer_node ctx e1 in
      let ctx' = Env.map (fun (vars, t) -> (vars, Subst.apply s1 t)) ctx in
      let s2, t2 = infer_node ctx' e2 in

      let fresh_in = Types.next_var () in
      let fresh_mid = Types.next_var () in
      let fresh_out = Types.next_var () in

      let s3 = Subst.unify (Subst.apply s2 t1) (TArrow (fresh_in, fresh_mid)) in
      let s4 =
        Subst.unify (Subst.apply s3 t2)
          (TArrow (Subst.apply s3 fresh_mid, fresh_out))
      in

      let final_subst =
        Subst.compose s4 (Subst.compose s3 (Subst.compose s2 s1))
      in
      let inferred_arrow =
        TArrow
          (Subst.apply final_subst fresh_in, Subst.apply final_subst fresh_out)
      in
      (final_subst, inferred_arrow)
  | Graph.Fanout (e1, e2) ->
      let s1, t1 = infer_node ctx e1 in
      let ctx' = Env.map (fun (vars, t) -> (vars, Subst.apply s1 t)) ctx in
      let s2, t2 = infer_node ctx' e2 in

      let fresh_in = Types.next_var () in
      let out1 = Types.next_var () in
      let out2 = Types.next_var () in

      let s3 = Subst.unify (Subst.apply s2 t1) (TArrow (fresh_in, out1)) in
      let s4 = Subst.unify t2 (TArrow (Subst.apply s3 fresh_in, out2)) in

      let final_subst =
        Subst.compose s4 (Subst.compose s3 (Subst.compose s2 s1))
      in
      let inferred_arrow =
        TArrow
          ( Subst.apply final_subst fresh_in,
            TProd (Subst.apply final_subst out1, Subst.apply final_subst out2)
          )
      in
      (final_subst, inferred_arrow)
  | Graph.Fix (v, body) ->
      let fresh_in = Types.next_var () in
      let fresh_out = Types.next_var () in
      let loop_typ = Types.TArrow (fresh_in, fresh_out) in

      let recursive_ctx = Env.add v ([], loop_typ) ctx in
      let s1, body_typ = infer_node recursive_ctx body in

      let s2 = Subst.unify body_typ (Subst.apply s1 loop_typ) in
      let final_subst = Subst.compose s2 s1 in
      (final_subst, Subst.apply final_subst loop_typ)
  | Graph.Case branches ->
      if branches = [] then
        failwith "Type Error: Empty case blocks are strictly prohibited.";

      let fresh_in = Types.next_var () in
      let fresh_out = Types.next_var () in

      let infer_branch (accumulated_subst, running_ctx) (pat, body) =
        let pat_bindings, pat_typ = infer_pattern pat in
        let branch_ctx =
          Env.union (fun _ _ local -> Some local) running_ctx pat_bindings
        in
        let body_subst, body_typ = infer_node branch_ctx body in

        let current_in_typ =
          Subst.apply body_subst (Subst.apply accumulated_subst fresh_in)
        in
        let s_in =
          Subst.unify current_in_typ (Subst.apply body_subst pat_typ)
        in

        let unified_subst = Subst.compose s_in body_subst in
        let current_out_typ =
          Subst.apply unified_subst (Subst.apply accumulated_subst fresh_out)
        in

        let expected_arrow =
          Types.TArrow (Subst.apply unified_subst pat_typ, current_out_typ)
        in
        let s_out =
          Subst.unify (Subst.apply unified_subst body_typ) expected_arrow
        in

        let total_branch_subst = Subst.compose s_out unified_subst in
        let next_subst = Subst.compose total_branch_subst accumulated_subst in

        let next_ctx =
          Env.map
            (fun (vars, t) -> (vars, Subst.apply total_branch_subst t))
            running_ctx
        in
        (next_subst, next_ctx)
      in

      let final_subst, _ =
        List.fold_left infer_branch (Subst.empty, ctx) branches
      in
      let inferred_arrow =
        Types.TArrow
          (Subst.apply final_subst fresh_in, Subst.apply final_subst fresh_out)
      in
      (final_subst, inferred_arrow)
  | Graph.Tag (tag, e) ->
      let s1, t1 = infer_node ctx e in
      let fresh_in = Types.next_var () in
      let fresh_out = Types.next_var () in
      let s2 = Subst.unify t1 (TArrow (fresh_in, fresh_out)) in
      let final_subst = Subst.compose s2 s1 in
      let row_tail = Types.next_var () in
      let inferred_arrow =
        TArrow
          ( Subst.apply final_subst fresh_in,
            Types.TRowExtend (tag, Subst.apply final_subst fresh_out, row_tail)
          )
      in
      (final_subst, inferred_arrow)

let typecheck_program (prog : Graph.program) : unit =
  let _ =
    List.fold_left
      (fun acc_ctx (def : Graph.definition) ->
        let _, inferred_typ = infer_node acc_ctx def.graph in
        Env.add def.name (Scheme.generalize inferred_typ) acc_ctx)
      Env.empty prog
  in
  ()
