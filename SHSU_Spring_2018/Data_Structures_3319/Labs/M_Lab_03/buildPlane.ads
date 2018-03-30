with abstractStack;

package buildPlane is
	
	type string8 is new string(1..8);

	type vehicle2 is new abstractStack.abstStckElem with 
		record
			numDoors : integer;
			numEngines : integer;
			manufacturer : string8 := "manufact";
		end record;
	
	procedure getNumDoors(plane : in out vehicle2; n : in integer);
	procedure getManufacturer(plane : in out vehicle2; manufact : in string8);
	procedure getNumEngines(plane : in out vehicle2; e : in integer);
	procedure printString8(ptrStr : string8);
	procedure identifyVehicle(plane : in vehicle2);

end buildPlane;
