GetterBlock
  = ("(" __ ")" __)? block:Block {
      return {
        type: 'accessor',
        kind: 'getter',
        body: block.body
      };
    }

SetterBlock
  = param:("(" __ FunctionArgument __ ")" __)? block:Block {
      return {
        type: 'accessor',
        kind: 'setter',
        param: param ? param[2] || { type: 'argument', key: 'value' },
        body: block.body
      };
    }

GetterStatement
  = typename:(TypeName __)? GetToken __ identifier:Identifier __ getter:GetterBlock {
      getter.identifier = identifier;
      getter.returns = extractOptional(typename, 0);
      return append(getter);
    }

SetterStatement
  = typename:(TypeName __)? SetToken __ identifier:Identifier __ setter:SetterBlock {
      setter.identifier = identifier;
      setter.returns = extractOptional(typename, 0);
      return append(setter);
    }

GetterProperty
  = typename:(TypeName __)? GetToken __ key:PropertyName __ getter:GetterBlock {
      getter.type = 'property';
      getter.identifier = key;
      getter.returns = extractOptional(typename, 0);
      return append(getter);
    }

SetterProperty
  = typename:(TypeName __)? SetToken __ key:PropertyName __ setter:SetterBlock {
      setter.type = 'property';
      setter.identifier = key;
      setter.returns = extractOptional(typename, 0);
      return append(setter);
    }

GetAccessor
  = GetToken __ body:GetterBlock {
      return append(getter);
    }

SetAccessor
  = SetToken __ setter:SetterBlock {
      return append(setter);
    }

Accessor
  = GetAccessor
  / SetAccessor
