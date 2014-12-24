Literal
  = NullLiteral
  / BooleanLiteral
  / NumericLiteral
  / StringLiteral
  / RegExpLiteral
  / AttributeLiteral
  / CharLiteral

NullLiteral
  = NullToken { return append({ type: "literal", kind: "Null" }); }

BooleanLiteral
  = TrueToken  { return append({ type: "literal", kind: "Boolean", value: true }); }
  / FalseToken { return append({ type: "literal", kind: "Boolean", value: false }); }

@import "numbers.pegjs"

@import "strings.pegjs"

@import "regexps.pegjs"
