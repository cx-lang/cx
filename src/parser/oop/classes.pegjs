ClassStatement
  = m:(ObjectModifiers __)? macro:(MacroToken __)? ClassToken __ object:ClassHead properties:ClassBlock {
      if ( macro ) {
        object.type = "macro";
        object.kind = "class";
      }
      object.modifiers = extractOptional(m, 0) || [];
      object.properties = properties;
      return append(object);
    }

ClassHead
  = id:Identifier __ targs:(GenericArguments __)? ce:(ClassExtends __)? {
      return {
        type: "class",
        identifier: id,
        generics: extractOptional(targs, 0),
        extends: extractOptional(ce, 0)
      };
    }

ClassExtends
  = ":" first:TypeName rest:(__ "," __ TypeName)* { return buildList(first, rest, 3); }

ClassBlock
  = "{" __ "}" { return []; }
  / "{" __ first:ClassElement rest:(__ ClassElement)* __ "}" { return buildList(first, rest, 1); }

ClassElement
  = ClassIfStatement
  / StructElement
  / ClassStatement
  / InterfaceStatement
  / ExternStatement

ClassIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:ClassIfBlock right:(__ ElseToken __ ClassIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

ClassIfBlock
  = ClassBlock
  / e:ClassElement { return [e]; }

ClassExternStatement
  = m:(ObjectModifiers __)? ClassToken __ object:ClassHead properties:ClassExternBlock {
      object.modifiers = extractOptional(m, 0) || [];
      object.properties = properties;
      return append(object);
    }

ClassExternBlock
  = "{" __ "}" { return []; }
  / "{" __ first:ClassExternElement rest:(__ ClassExternElement)* __ "}" { return buildList(first, rest, 1); }

ClassExternElement
  = ClassExternIfStatement
  / InterfaceStatement
  / ExternElement

ClassExternIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:ClassExternIfBlock right:(__ ElseToken __ ClassExternIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

ClassExternIfBlock
  = ClassExternBlock
  / e:ClassExternElement { return [e]; }
