with ada.text_io, abstractStack;
use ada.text_io;

package body buildCar is
	package intIO is new ada.text_io.integer_io(integer);
	use intIO;

	procedure getNumDoors(car : in out vehicle; n : in integer) is
		begin
			car.numDoors := n;
			
		end getNumDoors;

	procedure getManufacturer(car : in out vehicle; manuf : in string5) is
		begin
			car.manufacturer := manuf;
			
		end getManufacturer;
	
	procedure printNumDoors(car : in vehicle) is
		begin
			put("Number of doors = ");
			put(car.numDoors);
			new_line;
		
		end printNumDoors;
	
	procedure printString5(ptrStr : string5) is
		begin
			for i in 1..5 
				loop
					put(ptrStr(i));
				end loop;
		
		end printString5;
	
	procedure printManufacturer(car : in vehicle) is
		begin
			put("Manufacturer is ");
			printString5(car.manufacturer);
			new_line;
		
		end printManufacturer;
	
	procedure identifyVehicle(car : in vehicle) is
		begin
			put("Built a ");
			printString5(car.manufacturer);
			put(" with ");
			put(car.numDoors);
			put(" doors.");
			new_line;
		
		end identifyVehicle;

	end buildCar;
