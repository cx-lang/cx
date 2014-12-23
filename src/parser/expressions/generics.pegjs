GenericName
  = identifier:IdentifierPath __ args:TemplateArguments {
      identifier.args = args;
      return append(identifier);
    }
  / IdentifierPath

TemplateArguments
  = "<" __ ">" { return []; }
  / "<" __ first:GenericType rest:(__ "," __ GenericType)* __ ">" {
      return buildList(first, rest, 3);
    }

TypeName
  = IdentifierPath
  / GenericName
