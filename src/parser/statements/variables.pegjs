VariableStatement
  = AwaitCall
  / VarToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "declarations", declarations: declarations });
    }
  / ConstToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "declarations", constants: true, declarations: declarations });
    }
  / LetToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "declarations", lets: true, declarations: declarations });
    }
  / typename:TypeName __ declarations:VariableDeclarations EOS? {
      return append({ type: "declarations", return: typename, declarations: declarations });
    }

VariableDeclarations
  = __ first:VariableAssignment rest:(__ "," __ VariableAssignment)* EOS {
      return buildList(first, rest, 3);
    }

VariableAssignment
  = Identifier
  / AwaitAssignment
  / identifier:Identifier __ "=" __ "{" __ accessor:Accessor __ "}" {
      accessor.identifier = identifier;
      var variable = {
        type: "variable",
        identifier: identifier
      };
      variable[accessor.kind === 'getter' ? 'get' : 'set'] = accessor;
      return append(variable);
    }
  / identifier:Identifier __ "=" __ "{" __ accessors:( GetAccessor __ ("," __)? SetAccessor ) __ "}" {
      accessors[0].identifier = identifier;
      accessors[3].identifier = identifier;
      return append({
        type: "variable",
        identifier: identifier,
        get: accessors[0],
        set: accessors[3]
      });
    }
  / identifier:Identifier __ "=" __ "{" __ accessors:( SetAccessor __ ("," __)? GetAccessor ) __ "}" {
      accessors[0].identifier = identifier;
      accessors[3].identifier = identifier;
      return append({
        type: "variable",
        identifier: identifier,
        get: accessors[3],
        set: accessors[0]
      });
    }
  / identifier:Identifier __ "=" __ value:AssignmentExpression {
      return append({ type: "variable", identifier: identifier, value: value });
    }
