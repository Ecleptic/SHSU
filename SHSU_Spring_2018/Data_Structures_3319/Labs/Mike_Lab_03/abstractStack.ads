package abstractStack is
	type abstStck is limited private;
	
	type abstStckElem is tagged private;
	type abstStckElemPtr is access all abstStckElem'class;
	
	procedure push(stack : access abstStck; y : in abstStckElemPtr);
	function pop(stack : access abstStck) return abstStckElemPtr;
	function stackSize(stack : access abstStck) return integer;
	function getElement(stack : access abstStck; y : in abstStckElemPtr) return abstStckElemPtr;
	
	private
		type abstStckElem is tagged
			record
				next : abstStckElemPtr;
			end record;
		
		type abstStck is limited
			record
				count : integer := 0;
				top : abstStckElemPtr := null;
			end record;

end abstractStack;
