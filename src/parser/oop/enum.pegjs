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
  = "(" __ first:EnumArgument rest:(__ ","? __ EnumArgument)* __ ")" { return buildList(first, rest, 3); }

EnumArgument
  = identifier:IdentifierName value:(__ (":" / "=") __ EnumValue)? {
      return append({ type: "variable", identifier: identifier, value: extractOptional(value, 3) });
    }

EnumValue
  = StringLiteral
  / NumericLiteral
