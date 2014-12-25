Statement
  = AbstractStatement
  / ClassStatement
  / NamespaceStatement
  / StructStatement
  / EnumStatement
  / ExternStatement
  / FunctionStatement
  / ImportStatement
  / MacroStatement
  / UsingStatement
  / GetterStatement
  / SetterStatement
  / VariableStatement
  / ExpressionStatement
  / IfStatement
  / IterationStatement
  / UsingStatement
  / SwitchStatement
  / ThrowStatement
  / TryStatement
  / PreprocessorStatement
  / CompilerStatement

StatementList
  = first:Statement rest:(__ Statement)* { return buildList(first, rest, 1); }
