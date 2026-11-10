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
