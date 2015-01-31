{
  @import "utils.js"
}

// parser entry point

  start
    = elements:NamespaceElements {
      return {
        type: 'program',
        name: options.filename,
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

@import "grammer"

@import "literals"

@import "expressions"

@import "statements"

@import "programs"
