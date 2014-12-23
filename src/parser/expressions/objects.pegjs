ObjectLiteral "object"
  = "{" __ "}" {
      return append({ type: 'object', properties: [] });
    }
  / "{" __ properties:PropertyList __ "}" {
      return append({ type: 'object', properties: properties });
    }

PropertyList
  = first:PropertyItem rest:(__ "," __ PropertyItem)* __ ","? {
      return buildList(first, rest, 3);
    }

PropertyItem
  = IdentifierName
  / MemberExpression
  / CallExpression
  / key:PropertyName __ ":" __ value:AssignmentExpression {
      return append({ type: 'property', kind: 'Assignment', key: key, value: value });
    }

PropertyName
  = IdentifierName
  / StringLiteral
  / NumericLiteral
