# unfurl's TOML dialect

unfurl reads a restricted subset of [TOML 1.0](https://toml.io/en/v1.0.0).

**Every file unfurl accepts is valid TOML and means the same thing as TOML.**
The reverse does not hold: plenty of valid TOML is rejected. When unfurl
rejects a TOML feature it does not support, the error names that feature.

## Encoding

The file must be pure ASCII. Any byte >= 0x80 is an error.

## Keys

Keys are C-style identifiers:

```
key = [A-Za-z_][A-Za-z0-9_]*
```

- no quoted keys (`"foo" = 1`, `'foo' = 1`)
- no leading digit (`2fast = true`)
- no `-` (`long-name = "x"`), even though TOML allows it in bare keys
- no dotted keys (`a.b = 1`)

```toml
help_text = "ok"      # accepted
"help" = "no"         # rejected: quoted key
max-count = 3         # rejected: '-' in key
```

## Arrays

Arrays are flat and contain only strings.

- no nested arrays (`[["a"], ["b"]]`)
- no other element types (`[1, 2]`, `[true]`)
- may span several lines, and may contain comments
- a trailing comma is allowed
- `[]` is syntactically valid; whether an empty array makes sense is up to
  the key it is assigned to

```toml
choices = ["png", "jpeg", "webp"]   # accepted

filters = [                         # accepted
    "nearest",
    "bilinear",  # comments are fine
    "lanczos",
]

sizes = [1, 2]                      # rejected: not a string
pairs = [["a", "b"]]                # rejected: nested array
```

## Grammar

Tokens: `Ident` (see Keys), `String`, `Integer`, `Boolean`, `[`, `[[`, `]`,
`]]`, `=`, `,`, `Newline`, `Eof`. Whitespace and comments are not tokens.

```
file     ::= stmt* Eof
stmt     ::= Newline
           | "[[" Ident "]]" end
           | "["  Ident "]"  end
           | Ident "=" value end
end      ::= Newline | Eof

value    ::= String | Integer | Boolean | array
array    ::= "[" nl* strings? "]"
strings  ::= String nl* ("," nl* String nl*)* ("," nl*)?
nl       ::= Newline
```

One token of lookahead decides every choice. `[` starts either a table header
or an array, but only ever at the start of a statement or of a value
respectively, never both.
