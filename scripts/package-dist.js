require('./globals');
var pkg = join(MODULE_DIR, 'package.json');
var version = require(pkg).version;

var modules = [];
function addModule ( filename, stat ){
  var data = readFile(filename).trim();
  modules.push(
    "'" + filename.replace(MODULE_DIR, 'cx') + "': function ( require, module, exports ) {\n" + (
      extname(filename) === '.json' ?
        indent("return " + data + ";")
      :
        indent(data).replace(/require\s*?\(\s*?("|')(.*)("|')\s*?\)/g, function(m, openOp, request, closeOp, index){
          var location = 'require statement in "' + filename + '" at ' + index;
          if ( openOp !== closeOp ) {
            throw new SyntaxError(location + ' has mismatched opening and closing characters.');
          }
          var first = request.charAt(0);
          if ( first === '/' || first === '\\' ) {
            throw new SyntaxError(location + ' is pointing to an absolute path.');
          }
          if ( first === '.' ) {
            request = resolve(stat.dirname, request).replace(MODULE_DIR, 'cx').replace(/\\/g, "/");
          }
          return "require(" + openOp + request + closeOp + ")";
        })
    ) + "\n}"
  );
}

addModule(pkg, lstat(pkg));
walk(LIB_DIR, addModule);

var output = readFile(join(SRC_DIR, 'dist-template.js'))
  .replace('__MODULES__', indent(modules.join(",\n\n")))
  .replace('__VERSION__', version);

writeFile(join(DIST_DIR, 'cx-' + version + '.js'), output);
writeFile(join(DIST_DIR, 'cx-' + version + '.min.js'), minify(output));
