UpdateExpression
  = left:Expression __ operator:UpdateOperator {
      return append({ type: "expression", kind: "update", left: left, operator: operator });
    }
  / CallExpression
  / NewExpression

UpdateOperator
  = "++"
  / "--"

UnaryExpression
  = operator:UnaryOperator __ right:Expression {
      return append({ type: "expression", kind: "unary", operator: operator, right: right });
    }
  / operator:UpdateOperator __ right:Expression {
      return append({ type: "expression", kind: "update", operator: operator, right: right });
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

RelationalExpression
  = left:Expression __ operator:RelationalOperator __ right:Expression {
      return append({ type: "expression", kind: "relational", left: left, operator: operator });
    }

RelationalOperator
  = $AsToken
  / $InstanceofToken
  / $InToken
  / "*"
  / "/"
  / "%"
  / "+"
  / "-"
  / "<<"
  / ">>"
  / "<="
  / ">="
  / "<"
  / ">"
  / "=="
  / "!="
  / "&"
  / "^"
  / "|"
  / "&&"
  / "||"
  / "??"

OperatorExpression
  = "(" __ left:Expression __ ")" __ right:Expression {
      return append({ type: "expression", kind: "cast", left: left, right: right });
    }
  / condition:Expression __ "?" __ left:Expression __ ":" __ right:Expression {
      return append({ type: "expression", kind: "if, condition: condition, pass: left, fail: right });
    }
  / RelationalExpression
  / UnaryExpression
  / UpdateExpression
