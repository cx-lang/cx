ThrowStatement
  = ThrowToken _ argument:Expression EOS? {
      return append({ type: "throw", argument: argument });
    }

TryStatement
  = TryToken __ block:Block handler:(__ Catch)? finalizer:(__ Finally) EOS? {
      return append({
        type:      "try",
        block:     block,
        handler:   extractOptional(handler, 1),
        finalizer: extractOptional(finalizer, 1)
      });
    }

Catch
  = CatchToken __ "(" __ param:(CatchArgument __)? ")" __ body:Block {
      return append({
        type:  "catch",
        param: extractOptional(param, 0),
        body:  body
      });
    }

CatchArgument "argument"
  = constant:(ConstToken __)? typename:(TypeName __)? identifier:Identifier {
      identifier.type = "argument";
      identifier.constant = constant != null;
      identifier.returns = extractOptional(typename, 0);
      return append(identifier);
    }

Finally
  = FinallyToken __ block:Block { return append(block); }
