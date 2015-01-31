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
  / destructor:DestructorExpression __ "=" __ UsingToken __ path:IdentifierPath EOS? {
      return append({ type: "using", path: path, destructor: destructor });
    }
  / UsingToken __ destructor:DestructorExpression __ OfToken __ path:ImportPath EOS? {
      return append({ type: "import", path: path, destructor: destructor });
    }

UsingBlockStatement
  = UsingToken __ "(" __ path:IdentifierPath __ ")" __ block:Block EOS? {
      return append({ type: "using", path: path, body: block.body });
    }
