ImportStatement
  = ImportToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path });
    }
  / ImportToken __ path:ImportPath __ AsToken __ identifier:Identifier EOS? {
      return append({ type: "import", path: path, identifier: identifier });
    }
  / identifier:Identifier __ "=" __ ImportToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, identifier: identifier });
    }
  / UsingToken __ identifier:Identifier __ "=" __ ImportToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, identifier: identifier });
    }
  / UsingToken? __ identifiers:DestructorExpression __ "=" __ ImportToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, identifiers: identifiers });
    }

ImportPath
  = IdentifierPath
  / StringLiteral
