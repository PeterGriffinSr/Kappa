
(* The type of tokens. *)

type token = 
  | Wildcard
  | TagName of (string)
  | String of (string)
  | Star
  | Snd
  | Slash
  | Semicolon
  | RParen
  | RBrace
  | RAngle
  | Plus
  | Minus
  | LParen
  | LBrace
  | LAngle
  | Int of (int)
  | Ident of (string)
  | Id
  | Fst
  | Fix
  | FatArrow
  | Eq
  | EOF
  | Define
  | Comma
  | Case
  | Caret
  | Bool of (bool)
  | Backslash
  | BackTick
  | Arrow

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Graph.program)
