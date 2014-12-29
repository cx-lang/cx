Library
  = elements:(__ LibraryElement)+ __ {
      return { type: 'library', name: options.filename, elements: extractList(elements, 1) };
    }

LibraryElement
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
