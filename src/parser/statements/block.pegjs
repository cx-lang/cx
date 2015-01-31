Block
  = "{" __ body:(StatementList __)? "}" {
      return append({
        type: "block",
        body: extractOptional(body, 0) || []
      });
    }
