let scramble_file ?(sort = false) ?(custom_seed: int option = None) ?(max_bytes = 4096) in_fname out_fname =
  let scramble_array = 
    if sort then (Array.sort Stdlib.compare)
    else (
      (match custom_seed with
        | Some v -> Random.init v
        | None -> Random.self_init ()
      );

      fun arr -> 
      (Array.shuffle ~rand:Random.int) arr
    )
  in
    
  let read_bytes =
    let rec read_bytes_aux buf ic len =
      match In_channel.input_byte ic with
      | Some current -> 
        if len = 0 then max_bytes
        else (
          buf.((Array.length buf) - len) <- current;
          read_bytes_aux buf ic (len - 1)
          )
      | None -> (max_bytes - len)
    
    in
    read_bytes_aux
  in

  let buffer = Array.make max_bytes 0 in
  let ic = In_channel.open_bin in_fname in
  let oc = Out_channel.open_bin out_fname in

  let rec scramble_all_aux ic oc =
    let write_length = read_bytes buffer ic max_bytes in

    let target_buffer = if write_length <> max_bytes then (Array.sub buffer 0 write_length) else buffer in
    scramble_array target_buffer;
    Array.iter (fun a -> Out_channel.output_byte oc a) target_buffer;

    if write_length = 0 then ()
    else scramble_all_aux ic oc
  in
  
  scramble_all_aux ic oc;
  In_channel.close ic;
  Out_channel.close oc