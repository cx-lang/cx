LambdaExpression
  = FunctionToken __ args:FunctionArguments __ block:Block {
      return append({ type: "lambda", kind: "function", args: args, body: block });
    }
  / kind:(MacroToken / AsyncToken) __ args:FunctionArguments __ block:Block {
      return append({ type: "lambda", kind: kind, args: args, body: block });
    }
  / kind:(MacroToken / AsyncToken) __ lambda:LambdaArrowExpression {
      lambda.kind = kind;
      return append(lambda);
    }
  / LambdaArrowExpression

LambdaArrowExpression
  = args:(LamdaArguments __)? operators:("=>" / "->") __ statement:Statement {
      return append({
        type: "lambda",
        kind: "arrow",
        args: args ? args[0] || [],
        operators: operators,
        body: statement
      });
    }

LamdaArguments
  = arg:FunctionArgument { return [arg]; }
  / FunctionArguments
