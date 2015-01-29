CharLiteral "char"
  = "'" ch:[\u0000-\uFFFF] "'" {
      return append({ type: "literal", kind: "char", value: ch, code: toCharCode(ch) });
    }
