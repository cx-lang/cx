Statement
  = Block
  / AbstractStatement
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

GeneratorStatement
  = YieldStatement
  / Statement

StatementList
  = first:Statement rest:(__ Statement)* { return buildList(first, rest, 1); }

GeneratorStatementList
  = first:GeneratorStatement rest:(__ GeneratorStatement)* { return buildList(first, rest, 1); }
