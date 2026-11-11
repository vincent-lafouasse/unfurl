(* big endian bytes, always 8 characters *)
type t = { bytes : string }

let zero : t = { bytes = String.make 8 '\000' }
let max_int : t = { bytes = String.make 8 '\255' }

(*
val of_string : string -> t option
val to_string : t -> string
val compare : t -> t -> int
val equal : t -> t -> bool
val of_int : int -> t option
*)
