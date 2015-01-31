Statement
  = LabelStatement
  / GetterStatement
  / SetterStatement
  / Block
  / AwaitStatement
  / DestructorStatement
  / UsingStatement
  / UsingBlockStatement
  / ImportStatement
  / VariableStatement
  / ExpressionStatement
  / IfStatement
  / DoStatement
  / WhileStatement
  / ForStatement
  / ContinueStatement
  / BreakStatement
  / GotoStatement
  / ReturnStatement
  / SwitchStatement
  / ThrowStatement
  / TryStatement
  / YieldStatement

StatementList
  = first:Statement rest:(__ Statement)* { return buildList(first, rest, 1); }
