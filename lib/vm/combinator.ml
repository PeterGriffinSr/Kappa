open Kappa_frontend

type value =
  | VInt of int
  | VBool of bool
  | VString of string
  | VTuple of value * value
  | VUnit
[@@deriving show]

type env = (string * combinator) list

and combinator =
  | Id
  | Constant of value
  | Prim of Graph.prim
  | Var of string
  | Compose of combinator * combinator
  | Fanout of combinator * combinator
  | Case of (Graph.pattern * combinator) list
  | Fix of string * combinator
[@@deriving show]

let rec match_pattern (pat : Graph.pattern) (v : value) :
    (string * value) list option =
  match (pat, v) with
  | PatWildcard, _ -> Some []
  | PatUnit, VUnit -> Some []
  | PatInt n, VInt m when n = m -> Some []
  | PatBool b1, VBool b2 when b1 = b2 -> Some []
  | PatString s1, VString s2 when s1 = s2 -> Some []
  | PatIdent id, _ -> Some [ (id, v) ]
  | PatTuple (p1, p2), VTuple (v1, v2) ->
      begin match (match_pattern p1 v1, match_pattern p2 v2) with
      | Some env1, Some env2 -> Some (env1 @ env2)
      | _ -> None
      end
  | _ -> None

let rec eval comb input env =
  match comb with
  | Id -> input
  | Constant v -> v
  | Var name ->
      begin match List.assoc_opt name env with
      | Some target_combinator -> eval target_combinator input env
      | None ->
          failwith
            (Printf.sprintf "Runtime Error: Unbound path identifier %s" name)
      end
  | Compose (c1, c2) ->
      let mid = eval c1 input env in
      eval c2 mid env
  | Fanout (c1, c2) -> VTuple (eval c1 input env, eval c2 input env)
  | Fix (v, body) ->
      let extended_env = (v, body) :: env in
      eval body input extended_env
  | Case branches ->
      let rec find_and_run = function
        | [] -> failwith "Runtime Error: Match failure in case block"
        | (pat, body) :: rest ->
            begin match match_pattern pat input with
            | Some bindings ->
                let constant_bindings =
                  List.map (fun (id, v) -> (id, Constant v)) bindings
                in
                eval body input (constant_bindings @ env)
            | None -> find_and_run rest
            end
      in
      find_and_run branches
  | Prim p ->
      begin match p with
      | Id -> input
      | Fst ->
          begin match input with
          | VTuple (l, _) -> l
          | _ -> failwith "Runtime Error: Fst expected tuple"
          end
      | Snd ->
          begin match input with
          | VTuple (_, r) -> r
          | _ -> failwith "Runtime Error: Snd expected tuple"
          end
      | Add ->
          begin match input with
          | VTuple (VInt a, VInt b) -> VInt (a + b)
          | _ -> failwith "Runtime Error: Add expected pair of integers"
          end
      | Sub ->
          begin match input with
          | VTuple (VInt a, VInt b) -> VInt (a - b)
          | _ -> failwith "Runtime Error: Sub expected pair of integers"
          end
      | Mul ->
          begin match input with
          | VTuple (VInt a, VInt b) -> VInt (a * b)
          | _ -> failwith "Runtime Error: Mul expected pair of integers"
          end
      | Div ->
          begin match input with
          | VTuple (VInt a, VInt b) ->
              if b = 0 then failwith "Runtime Error: Division by zero"
              else VInt (a / b)
          | _ -> failwith "Runtime Error: Div expected pair of integers"
          end
      | Eq ->
          begin match input with
          | VTuple (VInt a, VInt b) -> VBool (a = b)
          | _ -> failwith "Runtime Error: Eq expected pair of integers"
          end
      end
