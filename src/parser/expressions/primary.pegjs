PrimaryExpression
  = GlobalToken { return append({ type: "global" }); }
  / InternalToken { return append({ type: "internal" }); }
  / SuperToken { return append({ type: "super" }); }
  / ThisToken { return append({ type: "this" }); }
  / CompilerCommand
  / GenericName
  / Literal
  / ArrayLiteral
  / ObjectLiteral
  / "(" __ expression:Expression __ ")" { return expression; }
