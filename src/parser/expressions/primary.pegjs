PrimaryExpression
  = ThisToken { return append({ type: "this" }); }
  / GenericName
  / Literal
  / ArrayLiteral
  / ObjectLiteral
  / "(" __ expression:Expression __ ")" { return expression; }
