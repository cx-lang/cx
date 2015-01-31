YieldStatement
  = YieldToken __ statement:Statement {
      return append({ type: 'yield', statement: statement });
    }
