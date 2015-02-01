FriendStatement
  = FriendToken __ object:(IdentifierPath / FunctionExternStatement) {
      return append({ type: "friend", object: object });
    }
