AttributeLiteral "attribute"
  = "[" __ properties:AttributeList __ "]" {
      return append({ type: 'attributes', properties: properties });
    }

AttributeList
  = first:Attribute rest:(__ "," __ Attribute) {
      return buildList(first, rest, 3);
    }

Attribute
  = IdentifierName
  / IdentifierPath
  / CallExpression

Options
  = attributes:(AttributeLiteral __)? type:IdentifierPath {
      return { attributes: extractOptional(attributes, 0) || [], type: type };
    }
