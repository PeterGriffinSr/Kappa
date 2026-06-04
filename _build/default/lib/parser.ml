
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | Wildcard
    | TagName of 
# 7 "lib/parser.mly"
       (string)
# 16 "lib/parser.ml"
  
    | String of 
# 7 "lib/parser.mly"
       (string)
# 21 "lib/parser.ml"
  
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
    | Int of 
# 5 "lib/parser.mly"
       (int)
# 38 "lib/parser.ml"
  
    | Ident of 
# 7 "lib/parser.mly"
       (string)
# 43 "lib/parser.ml"
  
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
    | Bool of 
# 6 "lib/parser.mly"
       (bool)
# 58 "lib/parser.ml"
  
    | Backslash
    | BackTick
    | Arrow
  
end

include MenhirBasics

# 1 "lib/parser.mly"
  
open Graph

# 72 "lib/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_program) _menhir_state
    (** State 00.
        Stack shape : <empty>.
        Start symbol: program. *)

  | MenhirState02 : (('s, _menhir_box_program) _menhir_cell1_Ident, _menhir_box_program) _menhir_state
    (** State 02.
        Stack shape : Ident.
        Start symbol: program. *)

  | MenhirState08 : (('s, _menhir_box_program) _menhir_cell1_LParen, _menhir_box_program) _menhir_state
    (** State 08.
        Stack shape : LParen.
        Start symbol: program. *)

  | MenhirState10 : (('s, _menhir_box_program) _menhir_cell1_LAngle, _menhir_box_program) _menhir_state
    (** State 10.
        Stack shape : LAngle.
        Start symbol: program. *)

  | MenhirState17 : (('s, _menhir_box_program) _menhir_cell1_Fix _menhir_cell0_Ident, _menhir_box_program) _menhir_state
    (** State 17.
        Stack shape : Fix Ident.
        Start symbol: program. *)

  | MenhirState20 : (('s, _menhir_box_program) _menhir_cell1_Case, _menhir_box_program) _menhir_state
    (** State 20.
        Stack shape : Case.
        Start symbol: program. *)

  | MenhirState23 : (('s, _menhir_box_program) _menhir_cell1_LParen, _menhir_box_program) _menhir_state
    (** State 23.
        Stack shape : LParen.
        Start symbol: program. *)

  | MenhirState29 : (('s, _menhir_box_program) _menhir_cell1_BackTick _menhir_cell0_TagName, _menhir_box_program) _menhir_state
    (** State 29.
        Stack shape : BackTick TagName.
        Start symbol: program. *)

  | MenhirState32 : ((('s, _menhir_box_program) _menhir_cell1_LParen, _menhir_box_program) _menhir_cell1_pattern, _menhir_box_program) _menhir_state
    (** State 32.
        Stack shape : LParen pattern.
        Start symbol: program. *)

  | MenhirState36 : (('s, _menhir_box_program) _menhir_cell1_pattern, _menhir_box_program) _menhir_state
    (** State 36.
        Stack shape : pattern.
        Start symbol: program. *)

  | MenhirState49 : (('s, _menhir_box_program) _menhir_cell1_BackTick _menhir_cell0_TagName, _menhir_box_program) _menhir_state
    (** State 49.
        Stack shape : BackTick TagName.
        Start symbol: program. *)

  | MenhirState52 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 52.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState57 : (('s, _menhir_box_program) _menhir_cell1_case_branch, _menhir_box_program) _menhir_state
    (** State 57.
        Stack shape : case_branch.
        Start symbol: program. *)

  | MenhirState61 : ((('s, _menhir_box_program) _menhir_cell1_LAngle, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 61.
        Stack shape : LAngle expr.
        Start symbol: program. *)

  | MenhirState70 : (('s, _menhir_box_program) _menhir_cell1_definition, _menhir_box_program) _menhir_state
    (** State 70.
        Stack shape : definition.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_case_branch = 
  | MenhirCell1_case_branch of 's * ('s, 'r) _menhir_state * (Graph.pattern * Graph.graph_node)

and ('s, 'r) _menhir_cell1_definition = 
  | MenhirCell1_definition of 's * ('s, 'r) _menhir_state * (Graph.definition)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Graph.graph_node)

and ('s, 'r) _menhir_cell1_pattern = 
  | MenhirCell1_pattern of 's * ('s, 'r) _menhir_state * (Graph.pattern)

and ('s, 'r) _menhir_cell1_BackTick = 
  | MenhirCell1_BackTick of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_Caret = 
  | MenhirCell1_Caret of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_Case = 
  | MenhirCell1_Case of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_Fix = 
  | MenhirCell1_Fix of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_Ident = 
  | MenhirCell1_Ident of 's * ('s, 'r) _menhir_state * 
# 7 "lib/parser.mly"
       (string)
# 179 "lib/parser.ml"


and 's _menhir_cell0_Ident = 
  | MenhirCell0_Ident of 's * 
# 7 "lib/parser.mly"
       (string)
# 186 "lib/parser.ml"


and ('s, 'r) _menhir_cell1_LAngle = 
  | MenhirCell1_LAngle of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LParen = 
  | MenhirCell1_LParen of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_TagName = 
  | MenhirCell0_TagName of 's * 
# 7 "lib/parser.mly"
       (string)
# 199 "lib/parser.ml"


and _menhir_box_program = 
  | MenhirBox_program of (Graph.program) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 30 "lib/parser.mly"
         ( Prim Id )
# 210 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_02 =
  fun () ->
    (
# 31 "lib/parser.mly"
          ( Prim Snd )
# 218 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_03 =
  fun () ->
    (
# 32 "lib/parser.mly"
          ( Prim Fst )
# 226 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_04 =
  fun () ->
    (
# 33 "lib/parser.mly"
           ( Prim Add )
# 234 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_05 =
  fun () ->
    (
# 34 "lib/parser.mly"
            ( Prim Sub )
# 242 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_06 =
  fun () ->
    (
# 35 "lib/parser.mly"
           ( Prim Mul )
# 250 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_07 =
  fun () ->
    (
# 36 "lib/parser.mly"
            ( Prim Div )
# 258 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_08 =
  fun () ->
    (
# 37 "lib/parser.mly"
         ( Prim Eq )
# 266 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_09 =
  fun val_str ->
    (
# 38 "lib/parser.mly"
                                        ( Constant val_str )
# 274 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_10 =
  fun name ->
    (
# 39 "lib/parser.mly"
                   ( Var name )
# 282 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_11 =
  fun left right ->
    (
# 40 "lib/parser.mly"
                                                       ( Fanout(left, right) )
# 290 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_12 =
  fun body v ->
    (
# 41 "lib/parser.mly"
                                                    ( Fix(v, body) )
# 298 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_13 =
  fun branches ->
    (
# 42 "lib/parser.mly"
                                                         ( Case branches )
# 306 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_14 =
  fun e tag ->
    (
# 43 "lib/parser.mly"
                                             ( Tag(tag, e) )
# 314 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_15 =
  fun e ->
    (
# 44 "lib/parser.mly"
                               ( e )
# 322 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_16 =
  fun () ->
    (
# 45 "lib/parser.mly"
                     ( Constant "()" )
# 330 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_17 =
  fun body pat ->
    (
# 55 "lib/parser.mly"
                                         ( (pat, body) )
# 338 "lib/parser.ml"
     : (Graph.pattern * Graph.graph_node))

let _menhir_action_18 =
  fun n ->
    (
# 48 "lib/parser.mly"
            ( string_of_int n )
# 346 "lib/parser.ml"
     : (string))

let _menhir_action_19 =
  fun b ->
    (
# 49 "lib/parser.mly"
             ( string_of_bool b )
# 354 "lib/parser.ml"
     : (string))

let _menhir_action_20 =
  fun s ->
    (
# 50 "lib/parser.mly"
               ( Printf.sprintf "\"%s\"" s )
# 362 "lib/parser.ml"
     : (string))

let _menhir_action_21 =
  fun () ->
    (
# 51 "lib/parser.mly"
                   ( "()" )
# 370 "lib/parser.ml"
     : (string))

let _menhir_action_22 =
  fun l r ->
    (
# 52 "lib/parser.mly"
                                            ( Printf.sprintf "(%d,%d)" l r )
# 378 "lib/parser.ml"
     : (string))

let _menhir_action_23 =
  fun g name ->
    (
# 23 "lib/parser.mly"
                                      ( { name = name; graph = g } )
# 386 "lib/parser.ml"
     : (Graph.definition))

let _menhir_action_24 =
  fun e ->
    (
# 26 "lib/parser.mly"
                    ( e )
# 394 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_25 =
  fun e1 e2 ->
    (
# 27 "lib/parser.mly"
                                      ( Compose(e1, e2) )
# 402 "lib/parser.ml"
     : (Graph.graph_node))

let _menhir_action_26 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 410 "lib/parser.ml"
     : ((Graph.pattern * Graph.graph_node) list))

let _menhir_action_27 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 418 "lib/parser.ml"
     : ((Graph.pattern * Graph.graph_node) list))

let _menhir_action_28 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 426 "lib/parser.ml"
     : (Graph.program))

let _menhir_action_29 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 434 "lib/parser.ml"
     : (Graph.program))

let _menhir_action_30 =
  fun n ->
    (
# 58 "lib/parser.mly"
            ( PatInt n )
# 442 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_31 =
  fun b ->
    (
# 59 "lib/parser.mly"
             ( PatBool b )
# 450 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_32 =
  fun s ->
    (
# 60 "lib/parser.mly"
               ( PatString s )
# 458 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_33 =
  fun id ->
    (
# 61 "lib/parser.mly"
               ( PatIdent id )
# 466 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_34 =
  fun () ->
    (
# 62 "lib/parser.mly"
             ( PatWildcard )
# 474 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_35 =
  fun () ->
    (
# 63 "lib/parser.mly"
                   ( PatTuple(PatWildcard, PatWildcard) )
# 482 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_36 =
  fun l r ->
    (
# 64 "lib/parser.mly"
                                                    ( PatTuple(l, r) )
# 490 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_37 =
  fun pat tag ->
    (
# 65 "lib/parser.mly"
                                           ( PatTag(tag, pat) )
# 498 "lib/parser.ml"
     : (Graph.pattern))

let _menhir_action_38 =
  fun defs ->
    (
# 20 "lib/parser.mly"
                                   ( defs )
# 506 "lib/parser.ml"
     : (Graph.program))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | Wildcard ->
        "Wildcard"
    | TagName _ ->
        "TagName"
    | String _ ->
        "String"
    | Star ->
        "Star"
    | Snd ->
        "Snd"
    | Slash ->
        "Slash"
    | Semicolon ->
        "Semicolon"
    | RParen ->
        "RParen"
    | RBrace ->
        "RBrace"
    | RAngle ->
        "RAngle"
    | Plus ->
        "Plus"
    | Minus ->
        "Minus"
    | LParen ->
        "LParen"
    | LBrace ->
        "LBrace"
    | LAngle ->
        "LAngle"
    | Int _ ->
        "Int"
    | Ident _ ->
        "Ident"
    | Id ->
        "Id"
    | Fst ->
        "Fst"
    | Fix ->
        "Fix"
    | FatArrow ->
        "FatArrow"
    | Eq ->
        "Eq"
    | EOF ->
        "EOF"
    | Define ->
        "Define"
    | Comma ->
        "Comma"
    | Case ->
        "Case"
    | Caret ->
        "Caret"
    | Bool _ ->
        "Bool"
    | Backslash ->
        "Backslash"
    | BackTick ->
        "BackTick"
    | Arrow ->
        "Arrow"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_68 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let defs = _v in
      let _v = _menhir_action_38 defs in
      MenhirBox_program _v
  
  let rec _menhir_run_71 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_definition -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_definition (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_29 x xs in
      _menhir_goto_list_definition_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_definition_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_68 _menhir_stack _v
      | MenhirState70 ->
          _menhir_run_71 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_Ident (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Define ->
          let _menhir_s = MenhirState02 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Star ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Snd ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Slash ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Plus ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Minus ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LParen ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LAngle ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Ident _v ->
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Id ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fst ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fix ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Eq ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Case ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Caret ->
              _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BackTick ->
              _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_06 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_atom_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState49 ->
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState02 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState08 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState36 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState52 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState61 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_50 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_BackTick _menhir_cell0_TagName -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_TagName (_menhir_stack, tag) = _menhir_stack in
      let MenhirCell1_BackTick (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_14 e tag in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_54 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let e = _v in
      let _v = _menhir_action_24 e in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState36 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState52 ->
          _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState17 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState61 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState08 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState02 ->
          _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_51 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_pattern as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BackTick | Bool _ | Ident _ | Int _ | LParen | RBrace | String _ | Wildcard ->
          let MenhirCell1_pattern (_menhir_stack, _menhir_s, pat) = _menhir_stack in
          let body = _v in
          let _v = _menhir_action_17 body pat in
          let _menhir_stack = MenhirCell1_case_branch (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | Wildcard ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
          | String _v_0 ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState57
          | LParen ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
          | Int _v_1 ->
              _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState57
          | Ident _v_2 ->
              _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState57
          | Bool _v_3 ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState57
          | BackTick ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState57
          | RBrace ->
              let _v_4 = _menhir_action_26 () in
              _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  and _menhir_run_52 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState52 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Star ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Snd ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Slash ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Plus ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Minus ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LParen ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LAngle ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Ident _v ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | Id ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Fst ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Fix ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Eq ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Case ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Caret ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BackTick ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_02 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_07 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_04 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_05 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Star ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Snd ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Slash ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | RParen ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_16 () in
          _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | Plus ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Minus ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | LParen ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | LAngle ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Ident _v ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState08
      | Id ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Fst ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Fix ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Eq ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Case ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | Caret ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | BackTick ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LAngle (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState10 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Star ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Snd ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Slash ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Plus ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Minus ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LParen ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LAngle ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Ident _v ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | Id ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Fst ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Fix ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Eq ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Case ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | Caret ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BackTick ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let name = _v in
      let _v = _menhir_action_10 name in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_01 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_13 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_03 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_Fix (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Backslash ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Ident _v ->
              let _menhir_stack = MenhirCell0_Ident (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | Arrow ->
                  let _menhir_s = MenhirState17 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | Star ->
                      _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Snd ->
                      _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Slash ->
                      _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Plus ->
                      _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Minus ->
                      _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | LParen ->
                      _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | LAngle ->
                      _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Ident _v ->
                      _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | Id ->
                      _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Fst ->
                      _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Fix ->
                      _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Eq ->
                      _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Case ->
                      _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | Caret ->
                      _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | BackTick ->
                      _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_08 () in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_19 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_Case (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBrace ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Wildcard ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState20
          | String _v ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
          | LParen ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState20
          | Int _v ->
              _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
          | Ident _v ->
              _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
          | Bool _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
          | BackTick ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState20
          | RBrace ->
              let _v = _menhir_action_26 () in
              _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_34 () in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_pattern : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState23 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState20 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState57 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_30 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_BackTick _menhir_cell0_TagName -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_TagName (_menhir_stack, tag) = _menhir_stack in
      let MenhirCell1_BackTick (_menhir_stack, _menhir_s) = _menhir_stack in
      let pat = _v in
      let _v = _menhir_action_37 pat tag in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_31 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LParen as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | Comma ->
          let _menhir_s = MenhirState32 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Wildcard ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | String _v ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LParen ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Int _v ->
              _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Ident _v ->
              _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Bool _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BackTick ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_32 s in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_23 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Wildcard ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | String _v ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | RParen ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_35 () in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LParen ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | Int _v ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | Ident _v ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | Bool _v ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | BackTick ->
          let _menhir_stack = MenhirCell1_LParen (_menhir_stack, _menhir_s) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let n = _v in
      let _v = _menhir_action_30 n in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_26 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let id = _v in
      let _v = _menhir_action_33 id in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_27 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let b = _v in
      let _v = _menhir_action_31 b in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BackTick (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TagName _v ->
          let _menhir_stack = MenhirCell0_TagName (_menhir_stack, _v) in
          let _menhir_s = MenhirState29 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Wildcard ->
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | String _v ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LParen ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Int _v ->
              _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Ident _v ->
              _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Bool _v ->
              _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BackTick ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LParen, _menhir_box_program) _menhir_cell1_pattern -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RParen ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_pattern (_menhir_stack, _, l) = _menhir_stack in
          let MenhirCell1_LParen (_menhir_stack, _menhir_s) = _menhir_stack in
          let r = _v in
          let _v = _menhir_action_36 l r in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | FatArrow ->
          let _menhir_s = MenhirState36 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Star ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Snd ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Slash ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Plus ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Minus ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LParen ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LAngle ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Ident _v ->
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Id ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fst ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fix ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Eq ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Case ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Caret ->
              _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BackTick ->
              _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_Caret (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | String _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let s = _v in
          let _v = _menhir_action_20 s in
          _menhir_goto_constant_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | LParen ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | RParen ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_21 () in
              _menhir_goto_constant_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | Int _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | Comma ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | Int _v_0 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | RParen ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let (r, l) = (_v_0, _v) in
                          let _v = _menhir_action_22 l r in
                          _menhir_goto_constant_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | Int _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_18 n in
          _menhir_goto_constant_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | Bool _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_19 b in
          _menhir_goto_constant_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_constant_literal : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_Caret -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_Caret (_menhir_stack, _menhir_s) = _menhir_stack in
      let val_str = _v in
      let _v = _menhir_action_09 val_str in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_48 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BackTick (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TagName _v ->
          let _menhir_stack = MenhirCell0_TagName (_menhir_stack, _v) in
          let _menhir_s = MenhirState49 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Star ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Snd ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Slash ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Plus ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Minus ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LParen ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LAngle ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Ident _v ->
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Id ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fst ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fix ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Eq ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Case ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Caret ->
              _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BackTick ->
              _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_55 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_Case -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_Case (_menhir_stack, _menhir_s) = _menhir_stack in
      let branches = _v in
      let _v = _menhir_action_13 branches in
      _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_58 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_case_branch -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_case_branch (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_27 x xs in
      _menhir_goto_list_case_branch_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_case_branch_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState20 ->
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState57 ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_53 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_25 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_59 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_Fix _menhir_cell0_Ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BackTick | Bool _ | Comma | EOF | Ident _ | Int _ | LParen | RAngle | RBrace | RParen | String _ | Wildcard ->
          let MenhirCell0_Ident (_menhir_stack, v) = _menhir_stack in
          let MenhirCell1_Fix (_menhir_stack, _menhir_s) = _menhir_stack in
          let body = _v in
          let _v = _menhir_action_12 body v in
          _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_60 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LAngle as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | Comma ->
          let _menhir_s = MenhirState61 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | Star ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Snd ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Slash ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Plus ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Minus ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LParen ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LAngle ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Ident _v ->
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | Id ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fst ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Fix ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Eq ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Case ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | Caret ->
              _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BackTick ->
              _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_LAngle, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RAngle ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, left) = _menhir_stack in
          let MenhirCell1_LAngle (_menhir_stack, _menhir_s) = _menhir_stack in
          let right = _v in
          let _v = _menhir_action_11 left right in
          _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_64 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LParen as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RParen ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LParen (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_15 e in
          _menhir_goto_atom_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_66 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_Ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | Semicolon ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF | Ident _ ->
          let MenhirCell1_Ident (_menhir_stack, _menhir_s, name) = _menhir_stack in
          let g = _v in
          let _v = _menhir_action_23 g name in
          let _menhir_stack = MenhirCell1_definition (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | Ident _v_0 ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState70
          | EOF ->
              let _v_1 = _menhir_action_28 () in
              _menhir_run_71 _menhir_stack _v_1
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | Ident _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | EOF ->
          let _v = _menhir_action_28 () in
          _menhir_run_68 _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
