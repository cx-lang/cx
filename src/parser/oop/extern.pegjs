ExternStatement
  = ExternToken statement:ExternElement EOS? {
      return append({ type: "extern", statement: statement });
    }

ExternElement
  = UsingStatement
  / ExternIfStatement
  / OOPVariableExternStatement
  / OOPGetterExternStatement
  / OOPSetterExternStatement
  / OperatorOverloadExtern
  / FunctionExternStatement
  / EnumExternStatement
  / StructExternStatement
  / ClassExternStatement

ExternStructStatement
  = ExternToken statement:StructExternElement EOS? {
      return append({ type: "extern", statement: statement });
    }

ExternIfStatement
  = IfToken __ "(" __ test:Expression __ ")" __ left:ExternIfBlock right:(__ ElseToken __ ExternIfBlock)? {
      return append({
        type: "if",
        condition: test,
        consequent: left,
        alternate: extractOptional(right, 3)
      });
    }

ExternIfBlock
  = InterfaceBlock
  / e:ExternElement { return [e]; }
