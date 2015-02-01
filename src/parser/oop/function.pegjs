FunctionStatement
  = GeneratorExpression
  / FunctionExpression

FunctionExpression
  = LambdaExpression
  / inline:(InlineToken __)? returns:(TypeName __)? FunctionToken? __ identifier:Identifier __ fb:FunctionBody {
      return append({
        type: "function",
        inline: inline != null,
        identifier: identifier,
        returns: extractOptional(returns, 0),
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }
  / returns:(TypeName __)? token:(MacroToken / AsyncToken) __ identifier:Identifier __ fb:FunctionBody {
      return append({
        type: token,
        identifier: identifier,
        returns: extractOptional(returns, 0),
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }

GeneratorExpression
  = FunctionToken __ "*" __ identifier:Identifier __ fb:FunctionBody {
      return append({
        type: "generator",
        identifier: identifier,
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }

FunctionBody
  = generics:(GenericArguments __)? args:FunctionArguments __ block:Block {
      return { generics: extractOptional(generics, 0), args: args, block: block }
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
