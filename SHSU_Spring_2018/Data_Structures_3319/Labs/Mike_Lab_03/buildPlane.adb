with ada.text_io, abstractStack;
use ada.text_io;

package body buildPlane is
	package intIO is new ada.text_io.integer_io(integer);
	use intIO;
	
	procedure getNumDoors(plane : in out vehicle2; n : in integer) is
		begin
			plane.numDoors := n;
		
		end getNumDoors;
	
	procedure getManufacturer(plane: in out vehicle2; manufact : in string8) is
		begin 
			plane.manufacturer := manufact;
		
		end getManufacturer;
	
	procedure getNumEngines(plane : in out vehicle2; e : in integer) is
		begin
			plane.NumEngines := e;
		
		end getNumEngines;
	
	procedure printString8(ptrStr : string8) is
		begin
			for i in 1..8
				loop
					put(ptrStr(i));
				end loop;
			
		end printString8;
	
	procedure identifyVehicle(plane : in vehicle2) is
		begin
			put("Built a ");
			printString8(plane.manufacturer);
			put(" with ");
			put(plane.numDoors);
			put(" doors and ");
			put(plane.numEngines);
			put(" engines.");
			new_line;
		
		end identifyVehicle;

	end buildPlane;
