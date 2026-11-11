type t =
  | Identifier of string
  | Integer of Int65.t
  | Boolean of bool
  | String of string
  | LBracket
  | LLBracket
  | RBracket
  | RRBracket
  | Newline
  | Eof

let to_string = function
  | Identifier ident -> Printf.sprintf "identifier \"%s\"" ident
  | Integer i -> Printf.sprintf "integer %s" (Int65.to_string i)
  | Boolean b -> Printf.sprintf "boolean %s" (if b then "true" else "false")
  | String s -> Printf.sprintf "string \"%s\"" s
  | LBracket -> "["
  | LLBracket -> "[["
  | RBracket -> "]"
  | RRBracket -> "]]"
  | Newline -> "new line"
  | Eof -> "end of file"
;;
