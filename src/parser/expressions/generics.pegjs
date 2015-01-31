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
  = IdentifierPath
  / GenericName
