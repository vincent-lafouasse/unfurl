type t =
  { neg : bool
  ; mag : Uint64.t
  }

let make neg mag =
  if Uint64.equal mag Uint64.zero then { neg = false; mag } else { neg; mag }
;;

let of_literal s : t option =
  let neg, digits =
    if String.starts_with ~prefix:"-" s
    then true, String.sub s 1 (String.length s - 1)
    else false, s
  in
  Uint64.of_digits digits |> Option.map (make neg)
;;

let compare a b =
  match a.neg, b.neg with
  | false, false -> Uint64.compare a.mag b.mag
  | true, true -> Uint64.compare b.mag a.mag
  | true, false -> -1
  | false, true -> 1
;;

let to_string { neg; mag } =
  Printf.sprintf "%s%s" (if neg then "-" else "") (Uint64.to_string mag)
;;
