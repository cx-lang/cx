ObjectModifiers
  = first:ObjectModifier rest:(__ ObjectModifier)* { return buildModifiers(first, rest, 1); }

ObjectModifier
  = FinalToken
  / PartialToken
  / PropertyModifier

MethodModifiers
  = first:MethodModifier rest:(__ MethodModifier)* { return buildModifiers(first, rest, 1); }

MethodModifier
  = InlineToken
  / PropertyModifier

PropertyModifiers
  = first:PropertyModifier rest:(__ PropertyModifier)* { return buildModifiers(first, rest, 1); }

PropertyModifier
  = InternalToken
  / PrivateToken
  / ProtectedToken
  / PublicToken
  / StaticToken
