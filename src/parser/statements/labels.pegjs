LabelStatement
  = label:LabelName __ ":" block:(__ Block)? {
      return append({ type: "label", label: label, body: block.body });
    }

LabelName
  = Identifier
  / StringLiteral
  / NumericLiteral
