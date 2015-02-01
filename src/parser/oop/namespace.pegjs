Namespace
  = NamespaceToken __ identifier:IdentifierPath __ "{" __ elements:NamespaceElements __ "}" {
      return append({ type: 'namespace', identifier: identifier, elements: elements });
    }

NamespaceElements
  = elements:(__ NamespaceElement)* __ {
      return elements ? extractList(elements, 1) : [];
    }

NamespaceElement
  = Namespace
  / ImportStatement
  / UsingStatement
  / IfStatement
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
