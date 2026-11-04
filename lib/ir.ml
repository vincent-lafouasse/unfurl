type opt_kind =
  | Flag
  | Count
  | Int
  | String

type opt =
  { long : string
  ; short : char option
  ; kind : opt_kind
  }

let describe o = Printf.sprintf "--%s" o.long
