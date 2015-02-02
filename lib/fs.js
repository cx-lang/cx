var _ = require("./utils");
var fs = module.exports = {}, FS, PATH, isWindows;

try {

  FS = global.require('fs');
  PATH = global.require('path');
  isWindows = global.process.platform === 'win32';

} catch ( e ) {

  // browser polyfills will go here...

}

_.merge(fs, FS);

fs.join = PATH.join;
fs.resolve = PATH.resolve;
fs.dirname = PATH.dirname;
fs.basename = PATH.basename;
fs.extname = PATH.extname;

var backSlashes = /\\/g;
if ( isWindows ) {
  fs.join = function ( ) {
    return PATH.join.apply(null, arguments).replace(backSlashes, '/');
  };

  fs.resolve = function ( ) {
    return PATH.resolve.apply(null, arguments).replace(backSlashes, '/');
  };
}
