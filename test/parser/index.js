exports.name = "cx.parse";

exports.info = "perform tests on the parser, confirming correct output.";

exports.tests = [].concat(
  
	require("./start"),
	require("./grammer"),
	require("./literals"),
	require("./expressions"),
	require("./statements")
  
);