CharLiteral "char"
  = ch(
        "'" [\u0000-\uFFFF] "'"
      / '"' [\u0000-\uFFFF] '"'
      / "`" [\u0000-\uFFFF] "`"
    ) {
      return append({ type: "literal", kind: "char", value: ch[1], code: toCharCode(ch[1]) });
    }
