type t

val zero : t
val max_int : t

val compare : t -> t -> int
val equal : t -> t -> bool

val to_string : t -> string
