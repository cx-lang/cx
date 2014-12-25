ValueExpression
  = CallExpression
  / NewExpression

PreExpression
  = operator:PreOperators __ right:Expression {
      return append({ type: "expression", kind: "pre", operator: operator, right: right });
    }

PreOperators
  = $DeleteToken
  / $TypeofToken
  / "++"
  / "--"
  / "+"
  / "-"
  / "~"
  / "!"
  / "&"
  / "*"

PostExpression
  = left:Expression __ operator:PostOperators {
      return append({ type: "expression", kind: "post", left: left, operator: operator });
    }

PostOperators
  = "++"
  / "--"

MidExpression
  = left:Expression __ operator:MidOperators __ right:Expression {
      return append({ type: "expression", kind: "mid", left: left, operator: operator });
    }

MidOperators
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

Expression
  = ValueExpression
  / "(" __ left:Expression __ ")" __ right:Expression {
      return append({ type: "expression", kind: "cast", left: left, right: right });
    }
  / condition:Expression __ "?" __ left:Expression __ ":" __ right:Expression {
      return append({ type: "expression", kind: "if, condition: condition, pass: left, fail: right });
    }
  / MidExpression
  / PreExpression
  / PostExpression
