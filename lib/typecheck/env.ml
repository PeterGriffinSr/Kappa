open Types
module StringMap = Map.Make (String)

type t = Scheme.t StringMap.t

let empty = StringMap.empty
let singleton name scheme = StringMap.singleton name scheme
let find_opt name env = StringMap.find_opt name env
let add name scheme env = StringMap.add name scheme env
let map f env = StringMap.map f env
let union f env1 env2 = StringMap.union f env1 env2

let initial =
  let print_type = Types.TArrow (Types.next_var (), Types.TUnit) in
  let print_scheme = Scheme.generalize print_type in
  empty |> StringMap.add "print" print_scheme
