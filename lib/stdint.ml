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

let pow2 (n : int) : Int65.t = failwith "todo"

let min { signed; width } : Int65.t = failwith "todo"
let max { signed; width } : Int65.t = failwith "todo"

let fits (i : Int65.t) { signed; width } : bool = failwith "todo"
