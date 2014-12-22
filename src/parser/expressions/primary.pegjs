PrimaryExpression
  = ThisToken { return { type: "this" }; }
  / IdentifierPath
  / Literal
  / ArrayLiteral
  / ObjectLiteral
  / "(" __ expression:Expression __ ")" { return expression; }
