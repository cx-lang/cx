#!/usr/bin/env node
var cx = require("../");
var fs = require('fs');
var path = require('path');
var assert = require('assert');
var debug = require("debug")("cx");

var print = console.log;
var compact = function ( arr ) {
	return arr.filter(function(value){ return value != null; });
};

var filterModules = function ( item ) {
	var location = path.join(__dirname, "/" + item), module;
	if ( fs.statSync(location).isDirectory() ) {
    module = require(location);
    module.tests = module.tests.map(function(test){
      return { name: test.name, info: test.info, run: test.test, error: test.error };
    });
    return module;
	}
};

var modules, passes = 0, total = 0;
try {

	modules = compact(fs.readdirSync(__dirname).map(filterModules));
	if ( modules.length === 0 ) throw "no modules or tests found!";
  total = modules.length;
	
  modules.forEach(function(module, i){
    var tests = module.tests;
		print("\n[%d/%d] %s : %s...\n", ++i, total, module.name, module.info);
    
		tests.forEach(function(test, i){
			print("	+ %s (test %d of %d)", test.name, ++i, tests.length);
			assert(test.run(cx), test.error);
			++passes;
		});
    
	});
	print("\nFinished running %d tests in %d modules.", passes, total);

} catch ( err ) {
	if ( !err.stack ) throw err;
	
	console.log(err.stack);
	process.exit(1);
}
