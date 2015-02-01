LambdaExpression
  = kind:(FunctionToken / MacroToken / AsyncToken) __ fb:FunctionBody {
      return append({ type: "lambda", kind: kind, args: fb.args, body: fb.block });
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
