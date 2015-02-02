Statement
  = LabelStatement
  / GetterStatement
  / SetterStatement
  / Block
  / DestructorStatement
  / UsingStatement
  / UsingBlockStatement
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
