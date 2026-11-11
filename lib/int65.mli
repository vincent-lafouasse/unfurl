type t

val of_literal : string -> t option

val compare : t -> t -> int

val to_string : t -> string
