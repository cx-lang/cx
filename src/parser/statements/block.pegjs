Block
  = "{" __ body:(StatementList __)? "}" {
      return append({
        type: "block",
        body: extractOptional(body, 0) || []
      });
    }

GeneratorBlock
  = "{" __ body:(GeneratorStatementList __)? "}" {
      return append({
        type: "block",
        body: extractOptional(body, 0) || []
      });
    }
