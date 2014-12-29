FunctionStatement
  = FunctionExpression
  / GeneratorExpression

FunctionExpression
  = LambdaExpression
  / options:Options __ FunctionToken __ args:FunctionArguments __ block:Block {
      return append({ type: "function", options: options, args: args, body: block });
    }

GeneratorExpression
  = LambdaGeneratorExpression
  / options:Options __ FunctionToken __ "*" __ args:FunctionArguments __ block:GeneratorBlock {
      return append({ type: "generator", options: options, args: args, body: block });
    }

FunctionArguments "arguments"
  = "(" __ first:FunctionArgument rest:(__ "," __ FunctionArgument)* __ ")" { return buildList(first, rest, 3); }

FunctionArgument "argument"
  = constant:(ConstToken __)? variable:VariableAssignment {
      variable.type = "argument";
      variable.constant = constant != null;
      return variable;
    }

FunctionBody
  = args:FunctionArguments __ statements:Block {
      return { args: args, statements: statements }
    }
