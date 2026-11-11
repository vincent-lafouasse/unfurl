(* big endian bytes, always 8 characters *)
type t = string

let zero : t = String.make 8 '\000'
let max_int : t = String.make 8 '\255'

let compare = String.compare
let equal = String.equal

(* just reinterpret the bits *)
let to_i64 (u : t) : int64 = String.get_int64_be u 0

let to_string u = Printf.sprintf "%Lu" (to_i64 u)

let of_int64 (i : int64) : t =
  let b = Bytes.create 8 in
  Bytes.set_int64_be b 0 i;
  Bytes.unsafe_to_string b
;;

let of_int i = if i < 0 then None else Some (of_int64 (Int64.of_int i))

(*
val of_string : string -> t option
*)
