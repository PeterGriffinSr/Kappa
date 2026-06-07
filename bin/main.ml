open Kappa
open Kappa_vm

let parse_file filename =
  let in_channel = open_in filename in
  let lexbuf = Lexing.from_channel in_channel in
  try
    let program = Parser.program Lexer.token lexbuf in
    close_in in_channel;
    program
  with e ->
    close_in_noerr in_channel;
    raise e

let compile filename =
  try
    let prelude_program = parse_file "core/prelude.kp" in
    let user_program = parse_file filename in
    let combined_program = prelude_program @ user_program in
    Infer.typecheck_program combined_program;
    let _final_env =
      List.fold_left
        (fun acc_env (def : Graph.definition) ->
          let compiled_node = Compiler.compile_node def.graph in
          if def.name = "main" then begin
            let result =
              Combinator.eval compiled_node Combinator.VUnit acc_env
            in
            Printf.printf "Execution Result: %s\n"
              (Combinator.show_value result)
          end;
          (def.name, compiled_node) :: acc_env)
        [] combined_program
    in
    ()
  with
  | Sys_error msg -> Printf.eprintf "File Error: %s\n" msg
  | Failure msg -> Printf.eprintf "Error: %s\n" msg

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.printf "Usage: %s <source_file.kp>\n" Sys.argv.(0);
    exit 1
  end
  else compile Sys.argv.(1)
