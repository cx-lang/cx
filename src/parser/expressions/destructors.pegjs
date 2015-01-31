DestructorExpression
  = "{" __ identifiers:DestructorList __ "}" {
      return append({ type: "expression", kind: "destruct", elements: identifiers });
    }

DestructorList
  = first:DestructorItem rest:(__ "," __ DestructorItem)* {
      return buildList(first, rest, 3);
    }

DestructorItem
  = typename:(TypeName __)? key:(Identifier __ "=" __)? property:IdentifierPath {
      return append({
        type: "destructor",
        returns: extractOptional(typename, 0),
        key: extractOptional(key, 0),
        property: property
      });
    }
