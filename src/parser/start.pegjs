{
  @import "utils.js"
}

// parser entry point

  start
    = UIML
    / CSS
    / Library
    / Program
    / Script

@import "grammer"

@import "literals"

@import "expressions"

@import "statements"

@import "programs"
