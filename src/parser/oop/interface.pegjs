InterfaceStatement
  = object:InterfaceHead properties:InterfaceBlock {
      object.properties = properties;
      return append(object);
    }

InterfaceHead
  = m:(ObjectModifiers __)? InterfaceToken __ id:Identifier __ targs:(GenericArguments __)? ce:(ClassExtends __)? {
      return {
        type: "interface",
        modifiers: extractOptional(m, 0) || [],
        identifier: id,
        generics: extractOptional(targs, 0),
        extends: extractOptional(ce, 0)
      };
    }

InterfaceBlock
  = "{" __ "}" { return []; }
  / "{" __ first:ExternElement rest:(__ ExternElement)* __ "}" { return buildList(first, rest, 1); }
