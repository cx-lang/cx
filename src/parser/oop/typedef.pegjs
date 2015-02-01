TypedefStatement
  = TypedefToken __ identifier:Identifier __ "="? __ value:TypeName EOS? {
      return append({ type: "typedef", identifier: identifier, value: value });
    }
  / TypedefToken __ value:TypeName __ AsToken __ identifier:Identifier EOS? {
      return append({ type: "typedef", identifier: identifier, value: value });
    }
