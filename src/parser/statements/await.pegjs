AwaitAssignment
  = identifier:Identifier __ "=" __ value:AwaitCall {
      return append({ type: "variable", identifier: identifier, value: value });
    }
  / destructor:DestructorExpression __ "=" __ value:AwaitCall {
      return append({ type: "variable", destructor: destructor, value: value });
    }

AwaitCall
  = AwaitToken __ callback:KeyExpression {
      return append({ type: 'await', callback: callback });
    }
