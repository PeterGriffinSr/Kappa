open Types

type t = int list * Types.t

let rec free_vars = function
  | TVar v -> [ v ]
  | TProd (t1, t2) | TArrow (t1, t2) -> free_vars t1 @ free_vars t2
  | _ -> []

let generalize typ =
  let vars = free_vars typ |> List.sort_uniq Int.compare in
  (vars, typ)

let instantiate (vars, typ) =
  let fresh_subst =
    List.fold_left
      (fun acc v -> Subst.IntMap.add v (Types.next_var ()) acc)
      Subst.empty vars
  in
  Subst.apply fresh_subst typ
