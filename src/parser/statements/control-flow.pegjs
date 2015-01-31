ContinueStatement
  = ContinueToken EOS {
      return append({ type: "continue" });
    }
  / ContinueToken _ label:LabelName EOS {
      return append({ type: "continue", label: label });
    }

BreakStatement
  = BreakToken EOS {
      return append({ type: "break" });
    }
  / BreakToken _ label:LabelName EOS {
      return append({ type: "break", label: label });
    }

GotoStatement
  = GotoToken _ label:LabelName EOS {
      return append({ type: "goto", label: label });
    }

ReturnStatement
  = ReturnToken EOS {
      return append({ type: "return" });
    }
  / ReturnToken _ argument:Expression EOS {
      return append({ type: "return", argument: argument });
    }
