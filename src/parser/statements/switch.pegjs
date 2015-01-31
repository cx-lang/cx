SwitchStatement
  = SwitchToken __ "(" __ discriminant:Expression __ ")" __ cases:CaseBlock {
      return append({ type: "switch", discriminant: discriminant, cases: cases });
    }

CaseBlock
  = "{" __ clauses:(CaseClause __)* "}" {
      return clauses && clauses.length ? extractList(clauses, 0) : [];
    }

CaseClause
  = CaseToken __ test:CaseTest __ ":" consequent:(__ StatementList)? {
      return append({ type: "case", test: test, consequent: extractOptional(consequent, 1) || [] });
    }
  / DefaultToken __ ":" consequent:(__ StatementList)? {
      return append({ type: "case", test: null, consequent: extractOptional(consequent, 1) || [] });
    }

CaseTest
  = first:LabelName rest:(__ LabelName)* { return buildList(first, rest, 1); }
  / e:Expression { return [e]; }
