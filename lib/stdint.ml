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

type t =
  { signed : bool
  ; width : width
  }

let u8 = { signed = false; width = W8 }
let i8 = { signed = true; width = W8 }
let u16 = { signed = false; width = W16 }
let i16 = { signed = true; width = W16 }
let u32 = { signed = false; width = W32 }
let i32 = { signed = true; width = W32 }
let u64 = { signed = false; width = W64 }
let i64 = { signed = true; width = W64 }
