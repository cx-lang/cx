FunctionStatement
  = FunctionExpression
  / GeneratorExpression

FunctionExpression
  = LambdaExpression
  / returns:TypeName __ type:(FunctionToken / MacroToken / AsyncToken) __ fb:FunctionBody {
      return append({ type: type, returns: returns, args: fb.args, body: fb.block });
    }

GeneratorExpression
  = returns:TypeName __ FunctionToken __ "*" __ fb:FunctionBody {
      return append({ type: "generator", returns: returns, args: fb.args, body: fb.block });
    }

FunctionBody
  = args:FunctionArguments __ block:Block {
      return { args: args, block: block }
    }

FunctionArguments "arguments"
  = "(" __ first:FunctionArgument rest:(__ "," __ FunctionArgument)* __ ")" { return buildList(first, rest, 3); }

FunctionArgument "argument"
  = constant:(ConstToken __)? typename:(TypeName __)? identifier:Identifier value:(__ "=" __ AssignmentExpression)? {
      return append({
        type: "argument",
        constant: constant != null,
        returns: extractOptional(typename, 0),
        identifier: identifier,
        value: extractOptional(value, 3)
      });
    }
