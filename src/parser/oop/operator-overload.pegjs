OperatorOverloadStatement
  = modifiers:(MethodModifiers __)? returns:(TypeName __)? o:OverloadOperator __ lamda:LambdaArrow {
      return append({
        type: "operator",
        kind: "lamda",
        modifiers: extractOptional(modifiers, 0) || [],
        operator: o,
        returns: extractOptional(returns, 0),
        lamda: lamda
      });
    }
  / head:OverloadFunctionHead __ block:Block {
      head.body = block;
      return append(head);
    }

OverloadFunctionHead
  = modifiers:(MethodModifiers __)? returns:(TypeName __)? o:OverloadOperator __ args:FunctionArguments {
      return {
        type: "operator",
        kind: "function",
        modifiers: extractOptional(modifiers, 0) || [],
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
  = head:OverloadFunctionHead EOS? { return append(head); }
