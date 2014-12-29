UIML
  = elements:(__ UIMLElement)+ __ {
      return { type: 'uiml', name: options.filename, elements: extractList(elements, 1) };
    }
