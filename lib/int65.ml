type t =
  { neg : bool
  ; mag : Uint64.t
  }

let make ~neg ~mag =
  if Uint64.equal mag Uint64.zero then { neg = false; mag } else { neg; mag }
;;

let of_literal s : t option = failwith "todo"
