OperatorExpression
  = "(" __ typename:TypeName __ ")" __ expression:AssignmentExpression {
      return append({ type: "expression", kind: "cast", returns: typename, expression: expression });
    }
  / TernaryExpression

TernaryExpression
  = condition:RelationalExpression __ "?" __ left:AssignmentExpression right:(__ ":" __ AssignmentExpression)? {
      return append({
        type: "expression",
        kind: "ternary",
        condition: condition,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }
  / RelationalExpression
