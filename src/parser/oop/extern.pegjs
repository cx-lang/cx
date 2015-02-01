ExternStatement
  = ExternToken statement:ExternExpression EOS? {
      return append({ type: "extern", statement: statement });
    }

ExternExpression
  = returns:(TypeName __)? FunctionToken __ star:("*" __)? generics:(GenericArguments __)? args:FunctionArguments {
      return append({
        type: star ? "generator" : "function",
        returns: extractOptional(returns, 0),
        generics: extractOptional(generics, 0),
        args: args
      });
    }
  / returns:(TypeName __)? type:(MacroToken / AsyncToken) __ generics:(GenericArguments __)? args:FunctionArguments {
      return append({
        type: type,
        returns: extractOptional(returns, 0),
        generics: extractOptional(generics, 0),
        args: args
      });
    }
