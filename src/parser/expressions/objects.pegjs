ObjectLiteral "object"
  = "{" __ "}" {
      return append({ type: 'object', properties: [] });
    }
  / "{" __ properties:PropertyList __ "}" {
      return append({ type: 'object', properties: properties });
    }

PropertyList
  = first:ObjectProperty rest:(__ "," __ ObjectProperty)* __ ","? {
      return buildList(first, rest, 3);
    }

PropertyItemList
  = first:PropertyItem rest:(__ "," __ PropertyItem)* __ ","? {
      return buildList(first, rest, 3);
    }

PropertyItem
  = identifier:IdentifierName {
      return append({ type: 'property', kind: 'Identifier', key: identifier, value: identifier });
    }
  / expression:(MemberExpression / CallExpression) {
      return append({ type: 'property', kind: 'Expression', key: expression.property, value: expression });
    }
  / key:PropertyName __ ":" __ value:AssignmentExpression {
      return append({ type: 'property', kind: 'Assignment', key: key, value: value });
    }

ObjectProperty
 = PropertyItem
 / options:Options __ key:PropertyName __ ":" __ value:AssignmentExpression {
      return append({
        type: 'property',
        kind: 'Assignment',
        attributes: options.attributes,
        types: options.types,
        key: key,
        value: value
      });
    }
  / GetterProperty
  / SetterProperty

PropertyName
  = IdentifierName
  / StringLiteral
  / NumericLiteral
