UsingStatement
  = UsingToken __ path:IdentifierPath EOS? {
      return append({ type: "using", path: path });
    }
  / UsingToken __ path:IdentifierPath __ AsToken __ identifier:Identifier EOS? {
      return append({ type: "using", path: path, identifier: identifier });
    }
  / identifier:Identifier __ "=" __ UsingToken __ path:IdentifierPath EOS? {
      return append({ type: "using", path: path, identifier: identifier });
    }
  / identifiers:TypedDestructor __ "=" __ UsingToken __ path:IdentifierPath EOS? {
      return append({ type: "using", path: path, identifiers: identifiers });
    }
  / UsingToken __ identifiers:TypedDestructor __ OfToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, identifiers: identifiers });
    }

UsingBlockStatement
  = UsingToken __ "(" __ path:IdentifierPath __ ")" __ block:Block EOS? {
      return append({ type: "using", path: path, body: block.body });
    }
