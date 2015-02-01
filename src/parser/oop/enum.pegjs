EnumStatement
  = modifiers:(ObjectModifiers __)? EnumToken __ identifier:(Identifier __)? block:EnumBlock EOS? {
      return append({
        type: "enum",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: extractOptional(identifier, 0),
        variables: block
      });
    }

EnumBlock
  = "{" __ first:EnumArgument rest:(__ ","? __ EnumIfElement)* __ "}" { return buildList(first, rest, 3); }

EnumArgument
  = identifier:IdentifierName value:(__ (":" / "=") __ NumericLiteral)? {
      return append({ type: "variable", identifier: identifier, value: extractOptional(value, 3) });
    }

EnumIfElement
  = IfToken __ "(" __ test:Expression __ ")" __ left:EnumIfBlock right:(__ ElseToken __ EnumIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }
  / EnumArgument

EnumIfBlock
  = "{" __ "}" { return []; }
  / "{" __ first:EnumIfElement rest:(__ ","? __ EnumIfElement)* __ "}" { return buildList(first, rest, 3); }
  / e:EnumIfElement { return [e]; }

EnumExternStatement
  = modifiers:(ObjectModifiers __)? partial:(PartialToken __)? EnumToken __ identifier:(Identifier __)? block:EnumExternBlock EOS? {
      return append({
        type: "enum",
        modifiers: extractOptional(modifiers, 0) || [],
        identifier: extractOptional(identifier, 0),
        variables: block
      });
    }

EnumExternBlock
  = "{" __ first:EnumExternArgument rest:(__ ","? __ EnumExternIfElement)* __ "}" { return buildList(first, rest, 3); }

EnumExternArgument
  = identifier:IdentifierName {
      return append({ type: "variable", identifier: identifier });
    }

EnumExternIfElement
  = IfToken __ "(" __ test:Expression __ ")" __ left:EnumExternIfBlock right:(__ ElseToken __ EnumExternIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }
  / EnumExternArgument

EnumExternIfBlock
  = "{" __ "}" { return []; }
  / "{" __ first:EnumExternIfElement rest:(__ ","? __ EnumExternIfElement)* __ "}" { return buildList(first, rest, 3); }
  / e:EnumExternIfElement { return [e]; }
