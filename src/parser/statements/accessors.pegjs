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
  = options:(Options __)? GetToken __ identifier:Identifier __ getter:GetterBlock {
      getter.identifier = identifier;
      if ( options ) {
        getter.attributes = options[0].attributes;
        getter.returns = options[0].type;
      }
      return append(getter);
    }

SetterStatement
  = options:(Options __)? SetToken __ identifier:Identifier __ setter:SetterBlock {
      setter.identifier = identifier;
      if ( options ) {
        setter.attributes = options[0].attributes;
        setter.returns = options[0].type;
      }
      return append(setter);
    }

GetterProperty
  = options:(Options __)? GetToken __ key:PropertyName __ getter:GetterBlock {
      getter.type = 'property';
      getter.identifier = key;
      if ( options ) {
        getter.attributes = options[0].attributes;
        getter.returns = options[0].type;
      }
      return append(getter);
    }

SetterProperty
  = options:(Options __)? SetToken __ key:PropertyName __ setter:SetterBlock {
      getter.type = 'property';
      setter.identifier = key;
      if ( options ) {
        setter.attributes = options[0].attributes;
        setter.returns = options[0].type;
      }
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
