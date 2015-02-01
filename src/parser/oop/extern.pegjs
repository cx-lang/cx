ExternStatement
  = ExternToken statement:ExternExpression EOS? {
      return append({ type: "extern", statement: statement });
    }

ExternExpression
  = FunctionToken __ "*" __ id:Identifier __ targs:(GenericArguments __)? cargs:FunctionArguments {
      return append({
        type: "generator",
        identifier: id,
        generics: extractOptional(targs, 0),
        args: cargs
      });
    }
  / isof:(TypeName __)? FunctionToken? __ id:Identifier __ targs:(GenericArguments __)? cargs:FunctionArguments {
      return append({
        type: "function",
        identifier: id,
        returns: extractOptional(isof, 0),
        generics: extractOptional(targs, 0),
        args: cargs
      });
    }
  / isof:(TypeName __)? token:(MacroToken / AsyncToken) __ id:Identifier __ targs:(GenericArguments __)? cargs:FunctionArguments {
      return append({
        type: token,
        identifier: id,
        returns: extractOptional(isof, 0),
        generics: extractOptional(targs, 0),
        args: cargs
      });
    }
  / partial:(PartialToken __)? EnumToken __ identifier:(Identifier __)? block:EnumExternBlock EOS? {
      return append({
        type: "enum",
        partial: partial != null,
        identifier: extractOptional(identifier, 0),
        variables: block
      });
    }
