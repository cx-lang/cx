CX
  = elements:(__ CXElement)* __ {
      return { type: 'program', name: options.filename, elements: elements ? extractList(elements, 1) : [] };
    }

CXElement
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
  / VariableDeclaration
