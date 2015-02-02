OperatorOverloadStatement
  = modifiers:(MethodModifiers __)? returns:(TypeName __)? o:OverloadOperator __ lamda:LambdaArrow EOS? {
      return append({
        type: "operator",
        kind: "lamda",
        modifiers: extractOptional(modifiers, 0) || [],
        operator: o,
        returns: extractOptional(returns, 0),
        lamda: lamda
      });
    }
  / modifiers:(MethodModifiers __)? macro:(MacroToken __)? fn:OverloadFunctionHead __ block:Block EOS? {
      fn.modifiers = extractOptional(modifiers, 0) || [];
      if ( macro ) fn.kind = "macro";
      fn.body = block;
      return append(fn);
    }

OverloadFunctionHead
  = returns:(TypeName __)? o:OverloadOperator __ args:FunctionArguments {
      return {
        type: "operator",
        kind: "function",
        operator: o,
        returns: extractOptional(returns, 0),
        args: args
      };
    }

OverloadOperator
  = OperatorToken __ operator:OverloadOperators { return operator; }

OverloadOperators
  = "[" __ "]" { return "[]"; }
  / "." / "->"
  / RelationalOperator
  / UnaryOperator
  / UpdateOperator

OperatorOverloadExtern
  =  modifiers:(MethodModifiers __)? fn:OverloadFunctionHead EOS? {
      fn.modifiers = extractOptional(modifiers, 0) || [];
      return append(fn);
    }
