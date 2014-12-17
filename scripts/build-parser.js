require('./globals');

function preprocess ( input ) {
  var _included = [];

  function createOutput ( filename, data ) {
    var content = "";
    if ( data.trim() !== '' ) {
      content += "// @source: " + filename.replace(SRC_DIR, '.').replace(/\\/g, '/') + "\n\n  " + indent(data);
    }
    return content;
  }

  function commentedOut ( index, content ) {
    while ( (/( |\t)/).test(content.charAt(index - 1)) ) --index;
    return content.substring(index - 2, index) === '//';
  }

  function parseFile ( filename, rootname ) {
    if ( _included[filename] ) return '';
    _included[filename] = true;
    return readFile(filename).replace(/@import\s*?("|')(.*)("|')/g, function(m, openOp, request, closeOp, index, content){
      if ( commentedOut(index, content) ) return m;
      if ( openOp !== closeOp ) {
        throw new SyntaxError('import statement in "' + filename + '" at ' + index + ' has mismatched opening and closing characters.');
      }
      var path = join(rootname, request), data = "", isDirectory = false;
      if ( exists(path) && lstat(path).isDirectory() ) {
        path = join(path, 'index.pegjs');
        isDirectory = !exists(path);
      }
      if ( isDirectory ) {
        path = join(rootname, request);
        walk(path, function(filename, stat){
          data += createOutput(filename, parseFile(filename, stat.dirname)) + "\n\n";
        });
      } else {
        data = parseFile(path, dirname(path));
      }
      return createOutput(path, data.trim());
    });
  }

  return parseFile(input, dirname(input));
}

var parser = preprocess(join(SRC_DIR, 'parser', 'start.pegjs'));

writeFile(join(SRC_DIR, 'parser.pegjs'), parser);

if ( process.argv.indexOf('--no-peg-build') === -1 ) {
  writeFile(join(LIB_DIR, 'parser.js'), buildParser(parser));
}
