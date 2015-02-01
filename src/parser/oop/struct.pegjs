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
  = "{" __ first:StructElement rest:(__ StructElement)* __ "}" { return buildList(first, rest, 1); }

StructElement
  = VariableStatement
  / FunctionStatement
  / EnumStatement
  / ExternStructStatement

StructExternStatement
  = struct:StructHead properties:StructExternBlock {
      struct.properties = properties;
      return append(struct);
    }

StructExternBlock
  = "{" __ first:StructExternElement rest:(__ StructExternElement)* __ "}" { return buildList(first, rest, 1); }

StructExternElement
  = VariableExternStatement
  / FunctionExternStatement
  / EnumExternStatement
  / ExternStructStatement
