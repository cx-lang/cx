/*
  Copyright (c) 2015 Futago-za Ryuu <futagoza.ryuu@gmail.com>
  https://github.com/erispa/cx, v__VERSION__
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/
if ( typeof global === "undefined" ) var global = this;
(function(modules){

  // local variables
  var cx, factory, cache = {}, __hasOwnProperty = Object.prototype.hasOwnProperty;

  // simulates a module importer
  function require ( id ) {
    var name = id, module;
    if ( !__hasOwnProperty.call(modules, name) ) {
      name = name + '/index';
    }
    module = cache[name];
    if ( !module ) {
      if ( !__hasOwnProperty.call(modules, name) ) {
        throw new Error("cannot find module '" + id + "'");
      }
      module = cache[name] = { exports: {} };
      modules[name].call(
        null, require, module, module.exports
      );
    }
    return module.exports;
  }

  // Universal Module Definition (UMD) to support AMD, CommonJS/Node.js, Rhino, and plain browser loading
  cx = require('cx/lib/browser');
  cx.require = require;
  if ( typeof define === 'function' ) {
    factory = function ( ) { return cx; };
    if ( define.amd ) define(factory);
    else define('cx', [], factory);
  } else {
    if ( typeof exports !== 'undefined' ) {
      if ( typeof module !== 'undefined' ) {
        module.exports = cx;
      }
      exports.cx = cx;
    } else {
      global.cx = cx;
    }
  }

})({

__MODULES__

});