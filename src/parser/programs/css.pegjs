CSS
  = elements:(__ CSSRule)+ __ {
      return { type: 'css', name: options.filename, elements: extractList(elements, 1) };
    }