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
  / options:(Options __)? key:PropertyName __ ":" __ value:AssignmentExpression {
      var property = {
        type: 'property',
        kind: 'data',
        key: key,
        value: value,
        attributes: []
      };
      if ( options ) {
        property.attributes = options[0].attributes;
        property.returns = options[0].type;
      }
      return append(property);
    }
  / GetterProperty
  / SetterProperty

PropertyName
  = IdentifierName
  / StringLiteral
  / NumericLiteral
