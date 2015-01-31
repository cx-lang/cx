AwaitStatement
  = AwaitCall
  / VarToken __ declarations:AwaitDeclarations EOS? {
      return append({ type: "declarations", declarations: declarations });
    }
  / ConstToken __ declarations:AwaitDeclarations EOS? {
      return append({ type: "declarations", constants: true, declarations: declarations });
    }
  / LetToken __ declarations:AwaitDeclarations EOS? {
      return append({ type: "declarations", lets: true, declarations: declarations });
    }
  / typename:TypeName __ declarations:AwaitDeclarations EOS? {
      return append({ type: "declarations", return: typename, declarations: declarations });
    }

AwaitDeclarations
  = __ first:AwaitAssignment rest:(__ "," __ AwaitAssignment)* EOS {
      return buildList(first, rest, 3);
    }

AwaitAssignment
  = identifier:Identifier __ "=" __ value:AwaitCall {
      return append({ type: "variable", identifier: identifier, value: value });
    }
  / destructor:DestructorExpression __ "=" __ value:AwaitCall {
      return append({ type: "variable", destructor: destructor, value: value });
    }

AwaitCall
  = AwaitToken __ callback:KeyExpression {
      return append({ type: 'await', callback: callback });
    }
