LambdaExpression
  = kind:(FunctionToken / MacroToken / AsyncToken) __ args:FunctionArguments __ block:Block {
      return append({ type: "lambda", kind: kind, args: args, body: block });
    }
  / kind:(MacroToken / AsyncToken) __ lambda:LambdaArrowExpression {
      lambda.kind = kind;
      return append(lambda);
    }
  / LambdaArrowExpression

LambdaArrowExpression
  = args:(LamdaArguments __)? "=>" __ statement:Statement {
      return append({
        type: "lambda",
        kind: "arrow",
        args: args ? args[0] || [],
        body: statement
      });
    }

LamdaArguments
  = arg:FunctionArgument { return [arg]; }
  / FunctionArguments
