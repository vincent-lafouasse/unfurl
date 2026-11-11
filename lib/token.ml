type t =
  | Identifier of string
  | Integer of Int65.t
  | Boolean of bool
  | String of string
  | LBracket
  | LLBracket
  | RBracket
  | RRBracket
  | Eof

let format = function
  | Identifier ident -> Printf.sprintf "identifier \"%s\"" ident
  | Integer i -> failwith "need Int65.format"
  | Boolean b -> if b then "true" else "false"
  | String s -> Printf.sprintf "string \"%s\"" s
  | LBracket -> "["
  | LLBracket -> "[["
  | RBracket -> "]"
  | RRBracket -> "]]"
  | Eof -> "end of file"
;;
