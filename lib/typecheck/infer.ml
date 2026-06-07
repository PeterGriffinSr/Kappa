open Types
open Kappa_frontend

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
      let captured_rail_typ = Types.next_var () in
      let local_env = Env.add id ([], captured_rail_typ) Env.empty in
      (local_env, captured_rail_typ)
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
  | Graph.PatUnit -> (Env.empty, Types.TUnit)

let rec infer_node ctx node =
  match node with
  | Graph.Prim p -> (Subst.empty, infer_prim p)
  | Graph.Constant s ->
      let guess =
        match s with
        | "()" -> TUnit
        | _ when String.length s >= 2 && s.[0] = '"' -> TString
        | _ -> TInt
      in
      (Subst.empty, TArrow (Types.next_var (), guess))
  | Graph.Var name -> (
      match Env.find_opt name ctx with
      | Some scheme ->
          let inferred_typ = Scheme.instantiate scheme in
          begin match inferred_typ with
          | Types.TArrow (_, _) -> (Subst.empty, inferred_typ)
          | raw_data_rail ->
              let current_env_input = Types.next_var () in
              (Subst.empty, Types.TArrow (current_env_input, raw_data_rail))
          end
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

        let current_in =
          Subst.apply body_subst (Subst.apply accumulated_subst fresh_in)
        in
        let s_in = Subst.unify current_in (Subst.apply body_subst pat_typ) in
        let subst_so_far = Subst.compose s_in body_subst in

        let current_out =
          Subst.apply subst_so_far (Subst.apply accumulated_subst fresh_out)
        in
        let body_out =
          match Subst.apply subst_so_far body_typ with
          | Types.TArrow (_, o) -> o
          | t -> t
        in
        let s_out = Subst.unify body_out current_out in

        let total_subst = Subst.compose s_out subst_so_far in
        let next_subst = Subst.compose total_subst accumulated_subst in
        let next_ctx =
          Env.map
            (fun (vars, t) -> (vars, Subst.apply total_subst t))
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

let typecheck_program prog =
  let ctx_free_vars ctx =
    Env.fold
      (fun _ (bound, t) acc ->
        let scheme_free =
          Scheme.free_vars t |> List.filter (fun v -> not (List.mem v bound))
        in
        scheme_free @ acc)
      ctx []
  in
  let _ =
    List.fold_left
      (fun acc_ctx (def : Graph.definition) ->
        let _, inferred_typ = infer_node acc_ctx def.graph in
        let bound = ctx_free_vars acc_ctx in
        Env.add def.name
          (Scheme.generalize ~bound_vars:bound inferred_typ)
          acc_ctx)
      Env.initial prog
  in
  ()
