TypedefStatement
  = modifiers:(PropertyModifiers __)? TypedefToken __ identifier:Identifier __ "="? __ value:TypeName EOS? {
      return append({ type: "typedef", modifiers: extractOptional(modifiers, 0) || [], identifier: identifier, value: value });
    }
  / modifiers:(PropertyModifiers __)? TypedefToken __ value:TypeName __ AsToken __ identifier:Identifier EOS? {
      return append({ type: "typedef", modifiers: extractOptional(modifiers, 0) || [], identifier: identifier, value: value });
    }
