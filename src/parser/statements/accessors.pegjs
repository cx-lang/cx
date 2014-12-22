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
      if ( param ) {
        param = param[2];
      } else {
        param = { type: 'argument', key: 'value' };
      }
      return {
        type: 'accessor',
        kind: 'setter',
        param: param,
        body: block.body
      };
    }

GetterStatement
  = GetToken __ identifier:Identifier __ getter:GetterBlock {
      getter.identifier = identifier;
      return append(getter);
    }

SetterStatement
  = SetToken __ identifier:Identifier __ setter:SetterBlock {
      setter.identifier = identifier;
      return append(setter);
    }

GetterProperty
  = GetToken __ key:PropertyName __ getter:GetterBlock {
      getter.type = 'property';
      getter.identifier = key;
      return append(getter);
    }

SetterProperty
  = SetToken __ key:PropertyName __ setter:SetterBlock {
      getter.type = 'property';
      setter.identifier = key;
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
