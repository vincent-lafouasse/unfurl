type t =
  { input : string
  ; position : Position.t
  }

type error_kind =
  | UnrecognizedCharacter of char
  | UnterminatedStringLiteral
  | UnknownEscapeSequence of char (* e.g. \q *)

type error = error_kind Position.located

let init (input : string) : t =
  let position : Position.t = { absolute = 0; line = 1; column = 0 } in
  { input; position }
;;
