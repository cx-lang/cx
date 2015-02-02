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
  = UsingStatement
  / TypedefStatement
  / StructIfStatement
  / OOPVariableStatement
  / OOPGetterStatement
  / OOPSetterStatement
  / OperatorOverloadStatement
  / FunctionStatement
  / EnumStatement
  / FriendStatement
  / ExternStructStatement

StructIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:StructIfBlock right:(__ ElseToken __ StructIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

StructIfBlock
  = StructBlock
  / e:StructElement { return [e]; }

StructExternStatement
  = struct:StructHead properties:StructExternBlock {
      struct.properties = properties;
      return append(struct);
    }

StructExternBlock
  = "{" __ "}" { return []; }
  / "{" __ first:StructExternElement rest:(__ StructExternElement)* __ "}" { return buildList(first, rest, 1); }

StructExternElement
  = UsingStatement
  / StructExternIfStatement
  / OOPVariableExternStatement
  / OOPGetterExternStatement
  / OOPSetterExternStatement
  / OperatorOverloadExtern
  / FunctionExternStatement
  / EnumExternStatement
  / FriendStatement
  / ExternStructStatement

StructExternIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:StructExternIfBlock right:(__ ElseToken __ StructExternIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

StructExternIfBlock
  = StructExternBlock
  / e:StructExternElement { return [e]; }
