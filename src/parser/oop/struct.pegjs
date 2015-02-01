StructStatement
  = struct:StructHead properties:StructBlock {
      struct.properties = properties;
      return append(struct);
    }

StructHead
  = m:(ObjectModifiers __)? StructToken __ id:Identifier __ targs:(GenericArguments __)? cargs:(FunctionArguments __)? {
      return {
        type: "struct",
        modifiers: extractOptional(m, 0) || [],
        identifier: id,
        generics: extractOptional(targs, 0),
        args: extractOptional(cargs, 0)
      };
    }

StructBlock
  = "{" __ "}" { return []; }
  / "{" __ first:StructElement rest:(__ StructElement)* __ "}" { return buildList(first, rest, 1); }

StructElement
  = OOPVariableStatement
  / OOPGetterStatement
  / OOPSetterStatement
  / FunctionStatement
  / EnumStatement
  / FriendStatement
  / ExternStructStatement

StructExternStatement
  = struct:StructHead properties:StructExternBlock {
      struct.properties = properties;
      return append(struct);
    }

StructExternBlock
  = "{" __ "}" { return []; }
  / "{" __ first:StructExternElement rest:(__ StructExternElement)* __ "}" { return buildList(first, rest, 1); }

StructExternElement
  = OOPVariableExternStatement
  / OOPGetterExternStatement
  / OOPSetterExternStatement
  / FunctionExternStatement
  / EnumExternStatement
  / FriendStatement
  / ExternStructStatement
