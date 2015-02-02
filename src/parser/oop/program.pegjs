Program
  = __ elements:ProgramElements __ EOF {
      return {
        type: 'program',
        name: options.filename,
        api: '__API-VERSION__',
        program: {
          type: 'namespace',
          identifier: {
            type: 'identifier',
            value: 'global',
            pos: {
              start: { offset: 0, line: 1, column: 1 },
              end: { offset: 0, line: 1, column: 1 },
              range: [0, 0]
            }
          },
          elements: elements
        }
      };
    }

ProgramElements
  = first:NamespaceElement rest:(__ NamespaceElement)* { return buildList(first, rest, 1); }
