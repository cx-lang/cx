{
  @import "utils.js"
}

// parser entry point

  start
    = __ elements:(__ NamespaceElement __)* __ {
        return append({ type: 'namespace', name: 'global', elements: extractOptional(elements, 1), api: 'cx-0' });
      }

@import "grammer"

@import "literals"

@import "expressions"

@import "statements"

@import "TODO.pegjs"
