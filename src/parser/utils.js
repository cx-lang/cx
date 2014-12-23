function getLocation ( position ) {
  var details = peg$computePosDetails(position) || { line: 1, column: 1 };
  return { offset: position, line: details.line, column: details.column };
}

function append ( ast ) {
  ast.pos = {
    filename: options.filename,
    start: getLocation(peg$reportedPos),
    end: getLocation(peg$currPos),
    range: [peg$reportedPos, peg$currPos]
  };
  return ast;
}

function extractOptional ( optional, index ) {
  return optional ? optional[index] : null;
}

function extractList ( list, index ) {
  var result = [], i, length = list.length;
  for ( i = 0; i < length; ++i ) {
    result[i] = list[i][index];
  }
  return result;
}

function buildList ( first, rest, index ) {
  return [first].concat(typeof index === 'number' ? extractOptional(rest, index) : rest);
}

function buildTree ( first, rest, builder ) {
  var result = first, i, length = rest.length;
  for ( i = 0; i < length; ++i ) {
    result = builder(result, rest[i]);
  }
  return result;
}
