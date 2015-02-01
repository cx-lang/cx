OOPVariableStatement
  = modifiers:(PropertyModifiers __)? ast:VariableStatement {
      ast.modifiers = extractOptional(modifiers, 0) || [];
      return append(ast);
    }

OOPVariableExternStatement
  = modifiers:(PropertyModifiers __)? ast:VariableExternStatement {
      ast.modifiers = extractOptional(modifiers, 0) || [];
      return append(ast);
    }

VariableExternStatement
  = VarToken __ declarations:VariableExternDeclarations EOS? {
      return append({ type: "declarations", declarations: declarations });
    }
  / ConstToken __ declarations:VariableExternDeclarations EOS? {
      return append({ type: "declarations", constants: true, declarations: declarations });
    }
  / LetToken __ declarations:VariableExternDeclarations EOS? {
      return append({ type: "declarations", lets: true, declarations: declarations });
    }
  / typename:TypeName __ declarations:VariableExternDeclarations EOS? {
      return append({ type: "declarations", return: typename, declarations: declarations });
    }

VariableExternDeclarations
  = __ first:VariableExternAssignment rest:(__ "," __ VariableExternAssignment)* EOS {
      return buildList(first, rest, 3);
    }

VariableExternAssignment
  = Identifier
  / identifier:Identifier __ "=" __ "{" __ accessor:AccessorExtern __ "}" {
      accessor.identifier = identifier;
      var variable = {
        type: "variable",
        identifier: identifier
      };
      variable[accessor.kind === 'getter' ? 'get' : 'set'] = accessor;
      return append(variable);
    }
  / identifier:Identifier __ "=" __ "{" __ accessors:( GetAccessorExtern __ ("," __)? SetAccessorExtern ) __ "}" {
      accessors[0].identifier = identifier;
      accessors[3].identifier = identifier;
      return append({
        type: "variable",
        identifier: identifier,
        get: accessors[0],
        set: accessors[3]
      });
    }
  / identifier:Identifier __ "=" __ "{" __ accessors:( SetAccessorExtern __ ("," __)? GetAccessorExtern ) __ "}" {
      accessors[0].identifier = identifier;
      accessors[3].identifier = identifier;
      return append({
        type: "variable",
        identifier: identifier,
        get: accessors[3],
        set: accessors[0]
      });
    }
