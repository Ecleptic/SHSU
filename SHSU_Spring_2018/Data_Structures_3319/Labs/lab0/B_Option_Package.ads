package B_Option_Package is

	type NameType is (Burris, Zhou, Shashidhar, Shannon, Yang, Smith, Wei,
		Rabieh, Song, Cho, Varol, Karabiyik, Cooper, McGuire, Hope,
		Pray, NoHope);
	type arrayType is array(Integer range <>) of NameType;
	type intArray is array(Integer range <>) of integer;
	 
	function floor(x: float) return integer;
	function reallocate(StackSpace: in out arrayType; Info: in out intArray; Base: in out intArray;
		Top: in out intArray; L: integer; M: integer; N: integer; K: integer; input: NameType) return boolean;
	procedure movestack(StackSpace: in out arrayType; Info: intArray; Top: in out intArray;
		Base: in out intArray; N: integer);
		
end B_Option_Package;
