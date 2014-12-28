FunctionStatement
  = FunctionExpression
  / GeneratorExpression

FunctionExpression
  = LambdaExpression
  / options:Options __ FunctionToken __ args:FunctionArguments __ statements:Block {
      return append({ type: "function", options: options, args: args, statements: statements });
    }

GeneratorExpression
  = LambdaGeneratorExpression
  / options:Options __ FunctionToken __ "*" __ args:FunctionArguments __ block:GeneratorBlock {
      return append({ type: "generator", options: options, args: args, body: block });
    }

GeneratorBlock
  = "{" statements:(__ (Statement / YieldStatement))* __ "}" {
      return statements ? extractList(statements, 1) : [];
    }

FunctionArguments
  = "(" __ first:VariableDeclaration rest:(__ "," __ VariableDeclaration)* __ ")" { return buildList(first, rest, 3); }

VariableDeclaration
  = constant:(ConstToken __)? kind:TypeName __ identifier:Identifier value:(__ "=" __ AssignmentExpression)? {
      return append({ type: "variable", constant: constant != null, identifier: identifier, value: value || null });
    }

FunctionBody
  = args:FunctionArguments __ statements:Block {
      return { args: args, statements: statements }
    }
