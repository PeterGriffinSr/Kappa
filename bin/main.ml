open Kappa

let compile filename =
  let in_channel = open_in filename in
  let lexbuf = Lexing.from_channel in_channel in
  try
    let program = Parser.program Lexer.token lexbuf in
    close_in in_channel;
    Printf.printf "%s" (Graph.show_program program);
    Infer.typecheck_program program
  with Failure msg -> Printf.eprintf "Error: %s\n" msg

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.printf "Usage: %s <source_file.kp>\n" Sys.argv.(0);
    exit 1
  end
  else compile Sys.argv.(1)
