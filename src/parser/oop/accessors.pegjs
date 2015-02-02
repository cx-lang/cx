OOPGetterStatement
  = modifiers:(PropertyModifiers __)? ast:GetterStatement {
      ast.modifiers = extractOptional(modifiers, 0) || [];
      return append(ast);
    }

OOPSetterStatement
  = modifiers:(PropertyModifiers __)? ast:SetterStatement {
      ast.modifiers = extractOptional(modifiers, 0) || [];
      return append(ast);
    }

GetterBlockExtern
  = ("(" __ ")" __)? {
      return { type: 'accessor', kind: 'getter' };
    }

SetterBlockExtern
  = param:("(" __ FunctionArgument __ ")" __)? {
      return {
        type: 'accessor',
        kind: 'setter',
        param: param ? param[2] : { type: 'argument', key: 'value' }
      };
    }

OOPGetterExternStatement
  = modifiers:(PropertyModifiers __)? typename:(TypeName __)? GetToken __ identifier:Identifier __ getter:GetterBlockExtern EOS? {
      getter.modifiers = extractOptional(modifiers, 0) || [];
      getter.identifier = identifier;
      getter.returns = extractOptional(typename, 0);
      return append(getter);
    }

OOPSetterExternStatement
  = modifiers:(PropertyModifiers __)? typename:(TypeName __)? SetToken __ identifier:Identifier __ setter:SetterBlockExtern EOS? {
      setter.modifiers = extractOptional(modifiers, 0) || [];
      setter.identifier = identifier;
      setter.returns = extractOptional(typename, 0);
      return append(setter);
    }

GetAccessorExtern
  = GetToken __ body:GetterBlockExtern {
      return append(getter);
    }

SetAccessorExtern
  = SetToken __ setter:SetterBlockExtern {
      return append(setter);
    }

AccessorExtern
  = GetAccessorExtern
  / SetAccessorExtern
