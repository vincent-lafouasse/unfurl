type t

val zero : t
val max_int : t

(* only reachable error path is overflow so that's what None means 
   expected: only digits, no leading 0
*)
val of_digits : string -> t option

val compare : t -> t -> int
val equal : t -> t -> bool

val to_string : t -> string
val pp : Format.formatter -> t -> unit
