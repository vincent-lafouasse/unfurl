type width =
  | W8
  | W16
  | W32
  | W64

let bits = function
  | W8 -> 8
  | W16 -> 16
  | W32 -> 32
  | W64 -> 64
;;

type signed =
  | Signed
  | Unsigned

type t =
  { signed : signed
  ; width : width
  }

let u8 = { signed = Unsigned; width = W8 }
let i8 = { signed = Signed; width = W8 }
let u16 = { signed = Unsigned; width = W16 }
let i16 = { signed = Signed; width = W16 }
let u32 = { signed = Unsigned; width = W32 }
let i32 = { signed = Signed; width = W32 }
let u64 = { signed = Unsigned; width = W64 }
let i64 = { signed = Signed; width = W64 }

let lit s = Option.get (Int65.of_literal s)

let min ty =
  match ty.signed, ty.width with
  | Unsigned, _ -> lit "0"
  | Signed, W8 -> lit "-128"
  | Signed, W16 -> lit "-32768"
  | Signed, W32 -> lit "-2147483648"
  | Signed, W64 -> lit "-9223372036854775808"
;;

let max ty =
  match ty.signed, ty.width with
  | Unsigned, W8 -> lit "255"
  | Unsigned, W16 -> lit "65535"
  | Unsigned, W32 -> lit "4294967295"
  | Unsigned, W64 -> lit "18446744073709551615"
  | Signed, W8 -> lit "127"
  | Signed, W16 -> lit "32767"
  | Signed, W32 -> lit "2147483647"
  | Signed, W64 -> lit "9223372036854775807"
;;

let fits (i : Int65.t) { signed; width } : bool = failwith "todo"
