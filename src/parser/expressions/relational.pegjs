RelationalExpression
  = left:UnaryExpression __ operator:RelationalOperator __ right:UnaryExpression {
      return append({ type: "expression", kind: "relational", left: left, operator: operator, right: right });
    }
  / UnaryExpression

RelationalOperator
  = $AsToken
  / $InstanceofToken
  / $InToken
  / $OfToken
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
