with abstractStack;

package buildCar is
	
	type string5 is new string(1..5);
	
	type vehicle is new abstractStack.abstStckElem with 
		record
			numDoors : integer;
			manufacturer : string5 := "manuf";
		end record;
	
	procedure getNumDoors(car : in out vehicle; n : in integer);
	procedure getManufacturer(car : in out vehicle; manuf : in string5);
	procedure printNumDoors(car : in vehicle);
	procedure printString5(ptrStr : string5);
	procedure printManufacturer(car : in vehicle);
	procedure identifyVehicle(car : in Vehicle);

end buildCar;
