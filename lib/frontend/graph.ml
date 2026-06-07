type prim = Id | Add | Sub | Mul | Div | Eq | Snd | Fst [@@deriving show]

type graph_node =
  | Constant of string
  | Compose of graph_node * graph_node
  | Fanout of graph_node * graph_node
  | Fix of string * graph_node
  | Case of (pattern * graph_node) list
  | Prim of prim
  | Var of string
  | Tag of string * graph_node
[@@deriving show]

and pattern =
  | PatInt of int
  | PatBool of bool
  | PatString of string
  | PatTuple of pattern * pattern
  | PatIdent of string
  | PatTag of string * pattern
  | PatWildcard
  | PatUnit
[@@deriving show]

type definition = { name : string; graph : graph_node } [@@deriving show]
type program = definition list [@@deriving show]
