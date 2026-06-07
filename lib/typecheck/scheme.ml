open Types

type t = int list * Types.t

let rec free_vars = function
  | TVar v -> [ v ]
  | TProd (t1, t2) | TArrow (t1, t2) -> free_vars t1 @ free_vars t2
  | TRowExtend (_, t, tail) -> free_vars t @ free_vars tail
  | _ -> []

let generalize ?(bound_vars = []) typ =
  let vars =
    free_vars typ
    |> List.filter (fun v -> not (List.mem v bound_vars))
    |> List.sort_uniq Int.compare
  in
  (vars, typ)

let instantiate (vars, typ) =
  let fresh_subst =
    List.fold_left
      (fun acc v -> Subst.IntMap.add v (Types.next_var ()) acc)
      Subst.empty vars
  in
  Subst.apply fresh_subst typ
