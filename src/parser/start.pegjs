@import "utils.js"

// parser entry point

  start
    = __ elements:(__ MainBodyElement __)* __ {
        return append({ type: 'package', name: 'global', elements: extractOptional(elements, 1), api: 'cx-0' });
      }

  MainBodyElement
    = FunctionElement
    / ClassElement
    / PackageElement

@import "grammer"

@import "literals"

@import "expressions"

@import "statements"
