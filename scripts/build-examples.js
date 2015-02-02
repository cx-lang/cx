require('./globals');

var parser = require('../lib/parser');

var dirs = {
  cx: join(EXAMPLES_DIR, 'cx'),
  ast: join(EXAMPLES_DIR, 'ast'),
  js: join(EXAMPLES_DIR, 'js'),
  cpp: join(EXAMPLES_DIR, 'cpp')
};

var examples = [
  "macro.cx"
];

examples.forEach(function(example){
  
  var ast = parser.parse(readFile(join(dirs.cx, example)), { appendPos: false });
  
  writeFile(join(dirs.ast, example + '.json'), JSON.stringify(ast, null, "  "));
  
});
