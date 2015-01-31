DestructorStatement
  = VarToken __ declarations:DestructorDeclarations EOS? {
      return append({ type: "declarations", declarations: declarations });
    }
  / ConstToken __ declarations:DestructorDeclarations EOS? {
      return append({ type: "declarations", constants: true, declarations: declarations });
    }
  / LetToken __ declarations:DestructorDeclarations EOS? {
      return append({ type: "declarations", lets: true, declarations: declarations });
    }

DestructorDeclarations
  = __ first:DestructorAssignment rest:(__ "," __ DestructorAssignment)* EOS {
      return buildList(first, rest, 3);
    }

DestructorAssignment
  = destructor:DestructorExpression __ "=" __ value:AssignmentExpression {
      return append({ type: "variable", destructor: destructor, value: value });
    }
