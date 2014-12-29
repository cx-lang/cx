VariableStatement
  = VarToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "variables", declarations: declarations });
    }
  / ConstToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "constants", declarations: declarations });
    }
  / LetToken __ declarations:VariableDeclarations EOS? {
      return append({ type: "lets", declarations: declarations });
    }

VariableDeclarations
  = __ first:VariableAssignment rest:(__ "," __ VariableAssignment)* EOS {
      return buildList(first, rest, 3);
    }

VariableAssignment
  = kind:(TypeName __)? identifier:Identifier value:(__ "=" __ AssignmentExpression)? {
      return append({
        type: "variable",
        identifier: identifier,
        kind: extractOptional(kind, 0),
        value: extractOptional(value, 3)
      });
    }
