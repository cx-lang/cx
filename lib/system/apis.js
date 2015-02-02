/*
  The purpose of this file is simple, to serve as a wrapper for the node methods and settings that differ
  in different apis of the cx languages parser, allowing the compiler to compile types from older versions
  of the language, which in turn should allow the usage of old precompiled asts in modern asts.
*/

var _ = require('../utils');

var base = {
  Node: require('./base/node'),
  Scope: require('./base/scope'),
  types: {
    'identifier': require('./base/identifier'),
    'path': require('./base/identifier'),
    'literal': require('./base/literal'),
    'global': require('./base/scope'),
    'internal': require('./base/scope'),
    'super': require('./base/scope'),
    'this': require('./base/scope'),
    'command': require('./base/compile-time'),
    'array': require('./base/object'),
    'object': require('./base/object'),
    'property': require('./base/property'),
    'member': require('./base/member'),
    'new': require('./base/call'),
    'call': require('./base/call'),
    'expression': require('./base/expression'),
    'lambda': require('./base/lambda'),
    'destructor': require('./base/destructor'),
    'accessor': require('./base/accessor'),
    'declarations': require('./base/declarator'),
    'variable': require('./base/variable'),
    'if': require('./base/conditional'),
    'do': require('./base/iterator'),
    'while': require('./base/iterator'),
    'for': require('./base/iterator'),
    'continue': require('./base/control-flow'),
    'break': require('./base/control-flow'),
    'label': require('./base/label'),
    'goto': require('./base/control-flow'),
    'return': require('./base/control-flow'),
    'using': require('./base/compile-time'),
    'import': require('./base/compile-time'),
    'switch': require('./base/conditional'),
    'case': require('./base/label'),
    'throw': require('./base/error-control'),
    'try': require('./base/error-control'),
    'catch': require('./base/error-control'),
    'await': require('./base/await'),
    'friend': require('./base/friend'),
    'extern': require('./base/extern'),
    'function': require('./base/function'),
    'async': require('./base/function'),
    'generator': require('./base/function'),
    'argument': require('./base/declarator'),
    'typedef': require('./base/typedef'),
    'enum': require('./base/enum'),
    'struct': require('./base/class'),
    'class': require('./base/class'),
    'interface': require('./base/class'),
    'macro': require('./base/macro'),
    'operator': require('./base/function'),
    'namespace': require('./base/namespace')
  }
};

exports['cx-20141216'] = _.defaults({
  'program': require('./cx-20141216/program')
}, base);

exports.default = exports['cx-20141216'];
