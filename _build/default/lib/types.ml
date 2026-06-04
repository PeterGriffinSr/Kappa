type t =
  | TVar of int
  | TInt
  | TBool
  | TString
  | TUnit
  | TProd of t * t
  | TArrow of t * t
  | TRowEmpty
  | TRowExtend of string * t * t

let rec to_string = function
  | TVar v -> Printf.sprintf "'%c" (Char.chr (97 + (v mod 26)))
  | TInt -> "Int"
  | TBool -> "Bool"
  | TString -> "String"
  | TUnit -> "Unit"
  | TProd (t1, t2) -> Printf.sprintf "(%s * %s)" (to_string t1) (to_string t2)
  | TArrow (t1, t2) -> Printf.sprintf "%s -> %s" (to_string t1) (to_string t2)
  | TRowEmpty -> "[]"
  | TRowExtend (tag, t, tail) ->
      Printf.sprintf "[`%s of %s | %s]" tag (to_string t) (to_string tail)

let currentr_var = ref 0

let next_var () =
  let v = !currentr_var in
  incr currentr_var;
  TVar v
