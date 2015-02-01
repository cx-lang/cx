CompilerCommand
  = "@" expression:KeyExpression {
      return append({ type: "command", expression: expression });
    }
