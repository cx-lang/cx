Program
  = elements:(__ ProgramElement)* __ {
      return { type: 'program', name: options.filename, elements: elements ? extractList(elements, 1) : [] };
    }

ProgramElement
  = LibraryElement
  / Function
  / VariableDeclaration
