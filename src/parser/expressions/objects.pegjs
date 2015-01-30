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
  / typename:(TypeName __)? key:PropertyName __ ":" __ value:AssignmentExpression {
      return append({
        type: 'property',
        kind: 'data',
        key: key,
        value: value,
        returns: extractOptional(typename, 0)
      });
    }
  / GetterProperty
  / SetterProperty

PropertyName
  = IdentifierName
  / StringLiteral
  / NumericLiteral
