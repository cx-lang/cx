UpdateExpression
  = left:KeyExpression __ operator:UpdateOperator {
      return append({ type: "expression", kind: "update", expression: left, operator: operator });
    }
  / KeyExpression

UpdateOperator
  = "++"
  / "--"
