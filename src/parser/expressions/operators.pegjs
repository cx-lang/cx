OperatorExpression
  = "(" __ typename:TypeName __ ")" __ expression:Expression {
      return append({ type: "expression", kind: "cast", returns: typename, expression: expression });
    }
  / condition:Expression __ "?" __ left:Expression right:(__ ":" __ Expression)? {
      return append({
        type: "expression",
        kind: "ternary",
        condition: condition,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }
  / RelationalExpression
  / UnaryExpression
  / UpdateExpression
