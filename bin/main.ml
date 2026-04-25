let usage_msg = "scramble [-sort] [-s seed] <input> -o <output>"

let sort = ref false
let is_custom_seed = ref false
let seed = ref 0
let input_file = ref ""
let output_file = ref ""

let anon_fun filename =
  if !input_file = "" then
    input_file := filename
  else
    raise (Failure (!input_file ^ filename ^ "More than 1 anonymous argumant was passed"))

let speclist =
  [
    ("-sort", Arg.Set sort, "Sort bytes instead of shuffling them");
    ("-o", Arg.Set_string output_file, "Set output file name");
    ("-s", Arg.Int (fun inp -> is_custom_seed := true; seed := inp), "Set a custom seed");
  ]

let () = 
  Arg.parse speclist anon_fun usage_msg;
  if !input_file = "" || !output_file = "" then
    Arg.usage speclist usage_msg
  else
    Scramble.Scrambler.scramble_file ~sort:!sort ~custom_seed:(if !is_custom_seed then (Some !seed) else None) !input_file !output_file;
    Printf.printf "Done!\n%!";