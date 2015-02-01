MemberExpression
  = GenericName
  / first:(
        PrimaryExpression
      / FunctionExpression
      / NewToken __ callee:MemberExpression __ args:CallArguments {
          return append({ type: "new", callee: callee, arguments: args });
        }
    )
    rest:(
        __ "[" __ property:Expression __ "]" {
          return append({ property: property, computed: true });
        }
      / __ o:("." / "->") __ property:IdentifierName {
          return append({ property: property, computed: false, operator: o });
        }
    )*
    {
      return buildTree(first, rest, function(result, element){
        element.type = "member";
        element.object = result;
        return element;
      });
    }
