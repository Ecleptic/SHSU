with ada.text_io, abstractStack, buildCar, buildPlane;
use ada.text_io, abstractStack, buildCar, buildPlane;

procedure A_Option is
	package intIO is new ada.text_io.integer_io(integer);
	
	type stackPtr is access abstStck;
	vehicleStack : stackPtr := new abstStck;
	
	newVehicle : abstStckElemPtr;
	vehiclePt : abstStckElemPtr;
	newVehicle2 : abstStckElemPtr;
	
	printSize : integer;
	
	begin
		put("Inserting Ford with 4 doors...");
		new_line;
		newVehicle := new vehicle'(abstStckElem with 4, "Ford ");
		push(vehicleStack, newVehicle);
		
		put("Inserting Ford with 2 doors...");
		new_line;
		newVehicle := new vehicle'(abstStckElem with 2, "Ford ");
		push(vehicleStack, newVehicle);
		
		put("Inserting GMC with 2 doors...");
		new_line;
		newVehicle := new vehicle'(abstStckElem with 2, "GMC  ");
		push(vehicleStack, newVehicle);
		
		put("Inserting RAM with 2 doors...");
		new_line;
		newVehicle := new vehicle'(abstStckElem with 2, "RAM  ");
		push(vehicleStack, newVehicle);
		
		put("Inserting Chevy with 3 doors...");
		new_line;
		newVehicle := new vehicle'(abstStckElem with 3, "Chevy");
		push(vehicleStack, newVehicle);
		
		new_line;
		put("Number of items in list: ");
		printSize := stackSize(vehicleStack);
		intIO.put(printSize);
		new_line;
		
		new_line;
		put("Printing contents of list...");
		new_line;
		for i in 1..stackSize(vehicleStack)
			loop
				vehiclePt := getElement(vehicleStack, vehiclePt);
				if vehiclePt.all in vehicle then
					identifyVehicle(vehicle'class(vehiclePt.all));
				elsif vehiclePt.all in vehicle2 then
					identifyVehicle(vehicle2'class(vehiclePt.all));
				end if;
				new_line;
			end loop;		
		
		put("Number of items in list: ");
		printSize := stackSize(vehicleStack);
		intIO.put(printSize);
		new_line(2);
		
		put("Inserting Boeing with 3 doors and 6 engines...");
		new_line;
		newVehicle2 := new vehicle2'(abstStckElem with 3,6, "Boeing  ");
		push(vehicleStack, newVehicle2);
		
		put("Inserting Piper with 2 doors and 1 engines...");
		new_line;
		newVehicle2 := new vehicle2'(abstStckElem with 2,1, "Piper   ");
		push(vehicleStack, newVehicle2);
		
		put("Inserting Cessna with 4 doors and 4 engines...");
		new_line;
		newVehicle2 := new vehicle2'(abstStckElem with 4,4, "Cessna  ");
		push(vehicleStack, newVehicle2);
		
		new_line;
		put("Printing contents of list...");
		new_line;
		for i in 1..stackSize(vehicleStack)
			loop
				vehiclePt := getElement(vehicleStack, vehiclePt);
				if vehiclePt.all in vehicle then
					identifyVehicle(vehicle'class(vehiclePt.all));
				elsif vehiclePt.all in vehicle2 then
					identifyVehicle(vehicle2'class(vehiclePt.all));
				end if;
				new_line;
			end loop;	

	end A_Option;
