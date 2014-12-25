Expression
  = first:AssignmentExpression rest:(__ "," __ AssignmentExpression)* {
      return rest.length > 0 ? append({ type: "sequence", expressions: buildList(first, rest, 3) }) : first;
    }
