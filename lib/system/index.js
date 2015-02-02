var _ = require('../utils');
var EventEmitter = require('../events');
var parser = require('../parser');
var fs = require('../fs');
var apis = require('./apis');

var System = module.exports = function ( config ) {
  EventEmitter.call(this);
  this.paths = [];
  this.parser = parser;
  this.defaultApi = 'default';
  _.extend(this, config || {});
  this.api = apis[this.defaultApi];
};

_.inherits(System, EventEmitter);

System.prototype.parse = function ( code ) {
  return this.parser.parse(code, this);
};

System.prototype.resolve = function ( request ) {
  var paths = this.paths, length = paths.length, i, path;
  for ( i = 0; i < length;  ++i ) {
    path = fs.resolve(paths[i], request);
    if ( fs.existsSync(path) ) {
      return path;
    }
  }
  throw new Error("'" + request + "' could not be found");
};
