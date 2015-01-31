PrimaryExpression
  = ThisToken { return append({ type: "this" }); }
  / SuperToken { return append({ type: "super" }); }
  / GenericName
  / Literal
  / ArrayLiteral
  / ObjectLiteral
  / "(" __ expression:Expression __ ")" { return expression; }
