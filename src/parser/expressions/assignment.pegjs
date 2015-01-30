KeyExpression
  = CallExpression
  / NewExpression

AssignmentExpression
  = left:KeyExpression __ operator:AssignmentOperator __ right:AssignmentExpression {
      return append({ type: "expression", kind: "assignment", left: left, operator: operator, right: right });
    }
  / KeyExpression
  / LambdaExpression
  / OperatorExpression

AssignmentOperator
  = "="
  / "+="
  / "-="
  / "*="
  / "/="
  / "%="
  / "&="
  / "|="
  / "^="
  / "<<="
  / ">>="
