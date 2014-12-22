AttributeLiteral "attribute"
  = AttributeCall
  / AttributeAssignment
  / AttributeExpression

AttributeCall
  = "@" expression:CallExpression {
      expression.type = 'attribute';
      expression.kind = 'Call';
      return expression;
    }

AttributeAssignment
  = "@" label:(IdentifierName / MemberExpression) value:(__ "=" __ AssignmentExpression)? {
      return append({ type: 'attribute', kind: 'Assignment', label: label, value: extractOptional(value, 3)  });
    }

AttributeExpression
  = "@[" __ properties:PropertyList __ "]" {
      return append({ type: 'attribute', kind:'Object', properties: properties });
    }

Options
  = attributes:AttributeLiteral? __ types:(TypeName __)* {
      return append({ type: 'attribute', kind: 'Options', attributes: attributes, types: extractOptional(types, 0) || [] });
    }

TypeName
  = IdentifierPath
  / MemberExpression
