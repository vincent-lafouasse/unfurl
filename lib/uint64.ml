(* big endian bytes, always 8 characters *)
type t = string

let zero : t = String.make 8 '\000'
let max_int : t = String.make 8 '\255'

let compare = String.compare
let equal = String.equal

(*
val of_string : string -> t option
val to_string : t -> string
val of_int : int -> t option
*)
