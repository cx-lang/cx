FunctionStatement
  = GeneratorExpression
  / FunctionExpression

FunctionExpression
  = modifiers:(MethodModifiers __)? lamda:LambdaArrowExpression {
      lamda.modifiers = extractOptional(modifiers, 0) || [];
      return append(lamda);
    }
  / modifiers:(MethodModifiers __)? returns:(TypeName __)? FunctionToken? __ fb:FunctionBody {
      return append({
        type: "function",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fb.identifier,
        returns: extractOptional(returns, 0),
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }
  / modifiers:(MethodModifiers __)? returns:(TypeName __)? token:(MacroToken / AsyncToken) __ fb:FunctionBody {
      return append({
        type: token,
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fb.identifier,
        returns: extractOptional(returns, 0),
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }

GeneratorExpression
  = modifiers:(MethodModifiers __)? FunctionToken __ "*" __ fb:FunctionBody {
      return append({
        type: "generator",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fb.identifier,
        generics: fb.generics,
        args: fb.args,
        body: fb.block
      });
    }

FunctionHead
  = identifier:Identifier generics:(__ GenericArguments)? __ args:FunctionArguments {
      return { identifier: identifier, generics: extractOptional(generics, 1), args: args };
    }

FunctionBody
  = head:FunctionHead __ block:Block {
      head.block = block;
      return head;
    }

FunctionArguments "arguments"
  = "(" __ ")" { return []; }
  / "(" __ first:FunctionArgument rest:(__ "," __ FunctionArgument)* __ ")" { return buildList(first, rest, 3); }

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

FunctionExternStatement
  = modifiers:(PropertyModifiers __)? FunctionToken __ "*" __ fh:FunctionHead {
      return append({
        type: "generator",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fh.identifier,
        generics: extractOptional(fh.generics, 0),
        args: fh.args
      });
    }
  / modifiers:(PropertyModifiers __)? isof:(TypeName __)? FunctionToken? __ fh:FunctionHead {
      return append({
        type: "function",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fh.identifier,
        returns: extractOptional(isof, 0),
        generics: extractOptional(fh.generics, 0),
        args: fh.args
      });
    }
  / modifiers:(PropertyModifiers __)? isof:(TypeName __)? AsyncToken __ fh:FunctionHead {
      return append({
        type: "async",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: fh.identifier,
        returns: extractOptional(isof, 0),
        generics: extractOptional(fh.generics, 0),
        args: fh.args
      });
    }
