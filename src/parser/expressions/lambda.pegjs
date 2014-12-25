LambdaExpression
  = args:FunctionArguments __ "=>" __ statement:Statement {
      return append({ type: "lambda", kind: "fat", args: args, body: statement });
    }
  / args:FunctionArguments __ "->" __ statement:Statement {
      return append({ type: "lambda", kind: "thin", args: args, body: statement });
    }
