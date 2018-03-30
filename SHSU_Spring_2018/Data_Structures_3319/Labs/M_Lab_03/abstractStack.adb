package body abstractStack is

procedure push(stack : access abstStck; y : in abstStckElemPtr) is
	
	begin
		y.next := stack.top;
		stack.top := y;
		stack.count := stack.count + 1;
	
	end push;
	
function pop(stack : access abstStck) return abstStckElemPtr is
	pt : abstStckElemPtr;
	
	begin
		if stack.top = null then
			return null;
		end if;
		
		stack.count := stack.count - 1;
		pt := stack.top;
		stack.top := stack.top.next;
		
		return pt;
		
	end pop;

function stackSize(stack : access abstStck) return integer is
	count : integer := stack.count;
	
	begin
		return count;
		
	end stackSize;

function getElement(stack : access abstStck; y : in abstStckElemPtr) return abstStckElemPtr is
	pt : abstStckElemPtr := y;
	returnedElem : abstStckElemPtr;

	begin
		if pt = null then
			pt := stack.top;
			returnedElem := pt;
		else
			pt := pt.next;
			returnedElem := pt;
		end if;
		
		return returnedElem;
	
	end getElement;
	
end abstractStack;
