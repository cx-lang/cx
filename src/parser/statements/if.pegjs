IfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:Statement right:(__ ElseToken __ Statement)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }
