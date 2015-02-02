DestructorExpression
  = "{" __ identifiers:DestructorList __ "}" {
      return append({ type: "expression", kind: "destruct", elements: identifiers });
    }

DestructorList
  = first:DestructorItem rest:(__ "," __ DestructorItem)* {
      return buildList(first, rest, 3);
    }

DestructorItem
  = key:(Identifier __ "=" __)? property:IdentifierPath {
      return append({
        type: "destructor",
        identifier: extractOptional(key, 0),
        property: property
      });
    }
  / typename:TypeName __ key:(Identifier __ "=" __)? property:IdentifierPath {
      return append({
        type: "destructor",
        returns: typename,
        identifier: extractOptional(key, 0),
        property: property
      });
    }
