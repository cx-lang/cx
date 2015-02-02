GenericName
  = identifier:IdentifierPath __ args:TemplateArguments {
      identifier.args = args;
      return append(identifier);
    }
  / IdentifierPath

TemplateArguments
  = "<" __ ">" { return []; }
  / "<" __ first:TypeName rest:(__ "," __ TypeName)* __ ">" {
      return buildList(first, rest, 3);
    }

TypeName
  = CompilerCommand
  / IdentifierPath
  / GenericName

GenericArguments
  = "<" __ first:GenericArgument rest:(__ "," __ GenericArgument)* __ ">" {
      return buildList(first, rest, 3);
    }

GenericArgument
  = identifier:Identifier value:(__ "=" __ TypeName)? {
      return append({
        type: "typedef",
        identifier: identifier,
        value: extractOptional(value, 3)
      });
    }
