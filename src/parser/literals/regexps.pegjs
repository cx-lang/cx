RegularExpressionLiteral "RegularExpression"
  = "/" chars:RegularExpressionCharacter* "/" flags:Flags? {
      return append({ type: "literal", kind: "RegularExpression", value: JSON.stringify(chars.join("")), flags: flags });
    }

RegularExpressionCharacter
  = '\\' "/" { return "/"; }
  / !"/" SourceCharacter { return text(); }

Flags
  = chars: AlphaCharacter+ {
      return chars.join("");
    }
