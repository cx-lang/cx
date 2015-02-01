ClassStatement
  = object:ClassHead properties:ClassBlock {
      object.properties = properties;
      return append(object);
    }

ClassHead
  = m:(ObjectModifiers __)? ClassToken __ id:Identifier __ targs:(GenericArguments __)? ce:(ClassExtends __)? {
      return {
        type: "class",
        modifiers: extractOptional(m, 0) || [],
        identifier: id,
        generics: extractOptional(targs, 0),
        extends: extractOptional(ce, 0)
      };
    }

ClassExtends
  = ":" first:TypeName rest:(__ "," __ TypeName)* { return buildList(first, rest, 3); }

ClassBlock
  = "{" __ "}" { return []; }
  / "{" __ first:ClassElement rest:(__ ClassElement)* __ "}" { return buildList(first, rest, 1); }

ClassElement
  = StructElement
  / ClassStatement
  / InterfaceStatement
  / ExternStatement

ClassExternStatement
  = object:ClassHead properties:ClassExternBlock {
      object.properties = properties;
      return append(object);
    }

ClassExternBlock
  = "{" __ "}" { return []; }
  / "{" __ first:ExternStatement rest:(__ ExternStatement)* __ "}" { return buildList(first, rest, 1); }
