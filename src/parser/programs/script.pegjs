Script
  = elements:(__ ScriptElement)* __ {
      return { type: 'script', name: options.filename, elements: elements ? extractList(elements, 1) : [] };
    }

ScriptElement
  = ProgramElement
  / FunctionBodyElement
