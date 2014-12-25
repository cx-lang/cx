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

RelationalExpression
  = left:Expression __ operator:RelationalOperators __ right:Expression {
      return append({ type: "expression", kind: "relational", left: left, operator: operator });
    }

RelationalOperators
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
  / RelationalExpression
  / PreExpression
  / PostExpression
