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
  / Abstract
  / Class
  / Interface
  / Macro
  / Struct
  / Enum
  / Extern
  / Using
  / Directive
  / Import
  / Function
  / Variable
