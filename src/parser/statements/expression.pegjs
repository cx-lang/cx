ExpressionStatement
  = !("{" / FunctionToken) expression:Expression EOS { return expression; }
