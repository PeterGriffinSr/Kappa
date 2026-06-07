%{
open Graph
%}

%token <int> Int
%token <bool> Bool
%token <string> Ident String TagName
%token Id Fix Case Snd Fst FFI BackTick Wildcard
%token Define Semicolon LAngle RAngle Comma Caret Backslash Arrow FatArrow
%token LBrace RBrace LParen RParen
%token Plus Minus Star Slash Eq
%token EOF

%start <Graph.program> program

%%

program:
    | defs = list(definition); EOF { defs }

definition:
    | name = Ident; Define; g = expr; { { name = name; graph = g } }

expr:
    | e = binding_expr { e }
    | e1 = expr; Semicolon; e2 = binding_expr { Compose(e1, e2) }

binding_expr:
    | e = tag_expr { e }
    | Fix; Backslash; v = Ident; Arrow; body = binding_expr { Fix(v, body) }

tag_expr:
    | e = atom_expr { e }
    | BackTick; tag = TagName; e = tag_expr { Tag(tag, e) }

atom_expr:
    | Id { Prim Id }
    | Snd { Prim Snd }
    | Fst { Prim Fst }
    | Plus { Prim Add }
    | Minus { Prim Sub }
    | Star { Prim Mul }
    | Slash { Prim Div }
    | Eq { Prim Eq }
    | Caret; val_str = constant_literal { Constant val_str }
    | Caret; LParen; l = Int; Comma; r = Int; RParen  { Fanout(Constant (string_of_int l), Constant (string_of_int r)) }
    | name = Ident { Var name }
    | LAngle; left = expr; Comma; right = expr; RAngle { Fanout(left, right) }
    | Case; LBrace; branches = list(case_branch); RBrace { Case branches }
    | LParen; e = expr; RParen { e }
    | LParen; RParen { Constant "()" }

constant_literal:
  | n = Int { string_of_int n }
  | b = Bool { string_of_bool b }
  | s = String { Printf.sprintf "\"%s\"" s }
  | LParen; RParen { "()" }

case_branch:
  | pat = pattern; FatArrow; body = expr { (pat, body) }

pattern:
  | n = Int { PatInt n }
  | b = Bool { PatBool b }
  | s = String { PatString s }
  | id = Ident { PatIdent id }
  | Wildcard { PatWildcard }
  | LParen; RParen { PatUnit }
  | LParen; l = pattern; Comma; r = pattern; RParen { PatTuple(l, r) }
  | BackTick; tag = TagName; pat = pattern { PatTag(tag, pat) }