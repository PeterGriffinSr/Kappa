{
open Parser
open Lexing

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_lnum = pos.pos_lnum + 1; pos_bol = lexbuf.lex_curr_pos }
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z' '_']
let ident = alpha (alpha | digit)*
let tag_ident = ['A'-'Z'] (alpha | digit)*
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule token = parse
  | whitespace { token lexbuf }
  | newline { next_line lexbuf; token lexbuf }
  | "--"[^'\n']* { token lexbuf }
  | "id" { Id }
  | "fix" { Fix }
  | "case" { Case }
  | "snd" { Snd }
  | "fst" { Fst }
  | ":=" { Define }
  | ';' { Semicolon }
  | '<' { LAngle }
  | '>' { RAngle }
  | ',' { Comma }
  | '^' { Caret }
  | '\\' { Backslash }
  | "->" { Arrow }
  | "=>" { FatArrow }
  | '{' { LBrace }
  | '}' { RBrace }
  | '(' { LParen }
  | ')' { RParen }
  | '+' { Plus }
  | '-' { Minus }
  | '*' { Star }
  | '/' { Slash }
  | "eq" { Eq }
  | '`' { BackTick }
  | '_' { Wildcard }
  | '"' ([^ '"']* as s) '"' { String(s) }
  | digit+ as n { Int(int_of_string n) }
  | tag_ident as tag { TagName(tag) }
  | ident as id { Ident(id) }
  | _ as c { failwith (Printf.sprintf "Unexpected character: %c" c) }
  | eof { EOF }