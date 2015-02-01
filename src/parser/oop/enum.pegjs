EnumStatement
  = partial:(PartialToken __)? EnumToken __ identifier:(Identifier __)? block:EnumBlock EOS? {
      return append({
        type: "enum",
        partial: partial != null,
        identifier: extractOptional(identifier, 0),
        variables: block
      });
    }

EnumBlock
  = "{" __ first:EnumArgument rest:(__ ","? __ EnumArgument)* __ "}" { return buildList(first, rest, 3); }

EnumArgument
  = identifier:IdentifierName value:(__ (":" / "=") __ NumericLiteral)? {
      return append({ type: "variable", identifier: identifier, value: extractOptional(value, 3) });
    }

EnumExternBlock
  = "{" __ first:EnumExternArgument rest:(__ ","? __ EnumExternArgument)* __ "}" { return buildList(first, rest, 3); }

EnumExternArgument
  = identifier:IdentifierName {
      return append({ type: "variable", identifier: identifier });
    }
