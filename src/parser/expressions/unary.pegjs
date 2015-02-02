UnaryExpression
  = UpdateExpression
  / operator:UpdateOperator __ right:UnaryExpression {
      return append({ type: "expression", kind: "update", operator: operator, expression: right, prefixed: true });
    }
  / operator:UnaryOperator __ right:UnaryExpression {
      return append({ type: "expression", kind: "unary", operator: operator, expression: right });
    }

UnaryOperator
  = $DeleteToken
  / $TypeofToken
  / "+"
  / "-"
  / "~"
  / "!"
  / "&"
  / "*"
