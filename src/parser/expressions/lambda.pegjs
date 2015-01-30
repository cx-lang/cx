LambdaExpression
  = args:LamdaArguments __ "=>" __ statement:Statement {
      return append({ type: "lambda", kind: "fat", args: args, body: statement });
    }
  / args:LamdaArguments __ "->" __ statement:Statement {
      return append({ type: "lambda", kind: "thin", args: args, body: statement });
    }

LamdaArguments
  = arg:FunctionArgument { return [arg]; }
  / FunctionArguments
