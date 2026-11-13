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

let len lexer = String.length lexer.input

let eof lexer = lexer.position.absolute >= len lexer

let at lexer (position : Position.t) = String.get lexer.input position.absolute

let get_unsafe lexer = at lexer lexer.position

let get lexer = if eof lexer then None else Some (get_unsafe lexer)
