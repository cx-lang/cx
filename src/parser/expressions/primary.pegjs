PrimaryExpression
  = ThisToken { return append({ type: "this" }); }
  / IdentifierPath
  / Literal
  / ArrayLiteral
  / ObjectLiteral
  / "(" __ expression:Expression __ ")" { return expression; }
