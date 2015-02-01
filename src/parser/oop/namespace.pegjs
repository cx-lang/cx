Namespace
  = NamespaceToken __ identifier:IdentifierPath __ elements:NamespaceBlock {
      return append({ type: 'namespace', identifier: identifier, elements: elements });
    }

NamespaceBlock
  = "{" __ "}" { return []; }
  = "{" __ first:NamespaceElement rest:(__ NamespaceElement)* __ "}" { return buildList(first, rest, 1); }

NamespaceElement
  = Namespace
  / ImportStatement
  / UsingStatement
  / NamespaceIfStatement
  / OOPVariableStatement
  / OOPGetterStatement
  / OOPSetterStatement
  / FunctionStatement
  / TypedefStatement
  / ExternStatement
  / EnumStatement
  / StructStatement
  / ClassStatement
  / InterfaceStatement

NamespaceIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:NamespaceIfBlock right:(__ ElseToken __ NamespaceIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

NamespaceIfBlock
  = NamespaceBlock
  / e:NamespaceElement { return [e]; }
