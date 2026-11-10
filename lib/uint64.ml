(*
0 <= hi < 2^32
0 <= lo < 2^32
value = hi * 2^32 + lo
*)
type t =
  { hi : int
  ; lo : int
  }

let zero : t = { hi = 0; lo = 0 }

(*
val max_int : t
val of_string : string -> t option
val to_string : t -> string
val compare : t -> t -> int
val equal : t -> t -> bool
val of_int : int -> t option
*)
