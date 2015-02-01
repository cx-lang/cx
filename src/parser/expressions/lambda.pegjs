LambdaExpression
  = kind:(FunctionToken / MacroToken / AsyncToken) __ args:FunctionArguments __ block:Block {
      return append({ type: "lambda", kind: kind, args: args, body: block });
    }
  / LambdaArrowExpression

LambdaArrowExpression
  = kind:(MacroToken / AsyncToken) __ lambda:LambdaArrow {
      lambda.kind = kind;
      return append(lambda);
    }
  / LambdaArrow

LambdaArrow
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
