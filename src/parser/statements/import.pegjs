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
  / UsingToken? __ destructor:DestructorExpression __ "=" __ ImportToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, destructor: destructor });
    }

ImportPath
  = IdentifierPath
  / StringLiteral
