generic
	type MyType is private;
	Output_File: String;
	with procedure get(X: in out MyType);
	with procedure put(X: MyType);
	with function convert(X: MyType) return String;
package gMultiStack is

	type arrayType is array(Integer range <>) of MyType;
	type intArray is array(Integer range <>) of integer;

	function floor(x: float) return integer;
	function getLowerBound return integer;
	function getUpperBound return integer;
	function getNumOfStacks return integer;
	procedure runMultiStack;
	function reallocate(StackSpace: in out arrayType;
		Info: in out intArray; Base: in out intArray;
		Top: in out intArray; L: integer; M: integer;
		N: integer; K: integer; input: MyType) return boolean;
	procedure movestack(StackSpace: in out arrayType;
		Info: intArray; Top: in out intArray;
		Base: in out intArray; N: integer);
	procedure print(StackSpace: arrayType; L: integer; M: integer;
		N: integer; Base: intArray; Top: intArray; Info: intArray);
end gMultiStack;