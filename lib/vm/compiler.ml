open Kappa_frontend
open Combinator

let rec compile_node node =
  match node with
  | Graph.Constant "()" -> Constant VUnit
  | Graph.Constant s ->
      let v =
        if String.length s >= 2 && s.[0] = '"' then
          VString (String.sub s 1 (String.length s - 2))
        else try VInt (int_of_string s) with _ -> VBool (bool_of_string s)
      in
      Constant v
  | Graph.Prim p -> Prim p
  | Graph.Var name -> Var name
  | Graph.Compose (e1, e2) -> Compose (compile_node e1, compile_node e2)
  | Graph.Fanout (e1, e2) -> Fanout (compile_node e1, compile_node e2)
  | Graph.Fix (v, body) -> Fix (v, compile_node body)
  | Graph.Tag (tag, e) -> compile_node e
  | Graph.Case branches ->
      let compiled_branches =
        List.map (fun (pat, body) -> (pat, compile_node body)) branches
      in
      Case compiled_branches

let compile_program prog =
  List.map
    (fun (def : Graph.definition) -> (def.name, compile_node def.graph))
    prog
