Identifier
  = !Keyword name:IdentifierName { return name; }

IdentifierName "identifier"
  = identifier:$(IdentifierStart IdentifierPart*) {
      return append({ type: 'identifier', value: identifier });
    }

IdentifierPath
  = first:Identifier rest:(__ "." __ IdentifierName)+ {
      return append({ type: 'path', value: buildList(first, parts, 3) });
    }
  / Identifier

IdentifierList
  = identifiers:(Identifier __)* {
      return identifiers ? identifiers[0] : [];
    }

IdentifierStart
  = AlphaCharacter
  / "$"
  / "_"
  / "\\" sequence:UnicodeEscapeSequence { return sequence; }

IdentifierPart
  = IdentifierStart
  / DecimalDigit
  / "\u200C"
  / "\u200D"

UnicodeEscapeSequence
  = "u" digits:$(HexDigit HexDigit HexDigit HexDigit) {
      return String.fromCharCode(parseInt(digits, 16));
    }
