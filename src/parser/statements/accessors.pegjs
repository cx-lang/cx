GetterBlock
  = "(" __ ")" __ block:Block {
      return { type: 'getter', body: block.body };
    }

SetterBlock
  = "(" __ param:FunctionArgument __ ")" __ block:Block {
      return { type: 'setter', param: param, body: block.body };
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
      getter.identifier = key;
      return append(getter);
    }

SetterProperty
  = SetToken __ key:PropertyName __ setter:SetterBlock {
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
