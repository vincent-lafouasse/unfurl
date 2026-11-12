type t =
  { input : string
  ; position : Position.t
  }
[@@deriving show]

type error_kind =
  | UnrecognizedCharacter of char
  | UnterminatedStringLiteral
  | UnknownEscapeSequence of char (* e.g. \q *)
[@@deriving show]

type error = error_kind Position.located [@@deriving show]

let init (input : string) : t =
  let position : Position.t = { absolute = 0; line = 1; column = 0 } in
  { input; position }
;;
