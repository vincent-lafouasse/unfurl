type t =
  { signed : bool
  ; width : int
  }

let u8 = { signed = false; width = 1 }
let i8 = { signed = true; width = 1 }
let u16 = { signed = false; width = 2 }
let i16 = { signed = true; width = 2 }
let u32 = { signed = false; width = 4 }
let i32 = { signed = true; width = 4 }
let u64 = { signed = false; width = 8 }
let i64 = { signed = true; width = 8 }
