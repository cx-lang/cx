require('./globals');
var version = require('../package.json').version;

var modules = [];

walk(LIB_DIR, function(filename, stat){
  modules.push(
    "'" + filename.replace(LIB_DIR, '') + "': function ( require, module, exports ) {\n" + 
      indent(readFile(filename)).replace(/require\s*?\(\s*?("|')(.*)("|')\s*?\)/g, function(m, openOp, request, closeOp, index){
        var location = 'require statement in "' + filename + '" at ' + index;
        if ( openOp !== closeOp ) {
          throw new SyntaxError(location + ' has mismatched opening and closing characters.');
        }
        var first = request.charAt(0);
        if ( first === '/' || first === '\\' ) {
          throw new SyntaxError(location + ' is pointing to an absolute path.');
        }
        if ( first === '.' ) {
          request = resolve(stat.dirname, request).replace(LIB_DIR, 'cx').replace(/\\/g, "/");
        }
        return "require(" + openOp + request + closeOp + ")";
      })
    + "\n}"
  );
});

var output = readFile(join(SRC_DIR, 'dist-template.js'))
  .replace('__MODULES__', modules.join(",\n\n"))
  .replace('__VERSION__', version);

writeFile(join(DIST_DIR, 'cx-' + version + '.js'), output);
writeFile(join(DIST_DIR, 'cx-' + version + '.min.js'), minify(output));
