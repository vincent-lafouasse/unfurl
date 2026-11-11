(* big endian bytes, always 8 characters *)
type t = { bytes : string }

let zero : t = { bytes = String.make 8 '\000' }
let max_int : t = { bytes = String.make 8 '\255' }

let compare { bytes = a } { bytes = b } = String.compare a b
let equal { bytes = a } { bytes = b } = String.equal a b

(*
val of_string : string -> t option
val to_string : t -> string
val of_int : int -> t option
*)
