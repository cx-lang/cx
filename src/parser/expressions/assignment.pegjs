AssignmentExpression
  = left:LeftHandSideExpression __ operator:AssignmentOperator __ right:Expression {
      return append({ type: "expression", kind: "assignment", left: left, operator: operator, right: right });
    }

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
