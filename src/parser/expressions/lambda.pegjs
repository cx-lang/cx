LambdaExpression
  = args:(LamdaArguments __)? "=>" __ statement:Statement {
      return append({ type: "lambda", kind: "fat", args: args ? args[0] || [], body: statement });
    }
  / args:(LamdaArguments __)? "->" __ statement:Statement {
      return append({ type: "lambda", kind: "thin", args: args ? args[0] || [], body: statement });
    }

LamdaArguments
  = arg:FunctionArgument { return [arg]; }
  / FunctionArguments
