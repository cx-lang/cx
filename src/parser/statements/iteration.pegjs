DoStatement
  = DoToken __ body:Statement __ WhileToken __ "(" __ test:Expression __ ")" EOS {
      return append({ type: "do", body: body, condition: test });
    }

WhileStatement
  = WhileToken __ "(" __ test:Expression __ ")" __ body:Statement {
      return append({ type: "while", condition: test, body: body });
    }

ForStatement
  = ForToken __ "(" __
      init:((Expression / VariableStatement) __)? ";" __ test:(Expression __)? ";" __ update:(Expression __)?
    ")" __ body:Statement {
      return append({
        type:   "for",
        init:   extractOptional(init, 0),
        test:   extractOptional(test, 0),
        update: extractOptional(update, 0),
        body:   body
      });
    }
  / ForToken __ "(" __ left:Identifier __ InToken __ right:Expression __ ")" __ body:Statement {
      return append({
        type:  "for",
        kind:  "in",
        identifier:  left,
        object: right,
        body:  body
      });
    }
  / ForToken __ "(" __ left:Expression __ AsToken __ right:ForKeyValue __ ")" __ body:Statement {
      return append({
        type:  "for",
        kind:  "as",
        object:  left,
        identifiers: right,
        body:  body
      });
    }
  / ForToken __ "(" __ left:ForKeyValue __ OfToken __ right:Expression __ ")" __ body:Statement {
      return append({
        type:  "for",
        kind:  "of",
        identifiers:  left,
        object: right,
        body:  body
      });
    }

ForKeyValue
  = key:Identifier __ "," __ value:Identifier {
      return { key: key, value: value };
    }

ContinueStatement
  = ContinueToken EOS {
      return append({ type: "continue" });
    }
  / ContinueToken _ label:Identifier EOS {
      return append({ type: "continue", label: label });
    }

BreakStatement
  = BreakToken EOS {
      return append({ type: "break" });
    }
  / BreakToken _ label:Identifier EOS {
      return append({ type: "break", label: label });
    }
