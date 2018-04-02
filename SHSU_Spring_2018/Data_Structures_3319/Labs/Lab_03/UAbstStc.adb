-----------
-- Cameron Green
-- Lab_03
-- A_Option
-----------

with Ada.Text_IO; use Ada.Text_io;
with AbstStck; use AbstStck;
with MakeCar, MakePlane; use MakeCar, MakePlane;

procedure UAbstStc is
   type Stack_Ptr is access AbstractStack;
   VehicleStack: Stack_Ptr := new AbstractStack;
   TempStack: Stack_Ptr := new AbstractStack;
   StackPoint: Stack_Ptr;
   NewCar,CarPt, NewPlane, PlanePt, VehiclePt: AbstractStackElementPtr;
   correctMake: boolean;
   tempKnt: Integer := 0;
begin
   put_line("Inserting a ford with 4 doors");
   NewCar := new Car'(AbstractStackElement with 4, "Ford"); -- Heap allocation!
   PushBot(VehicleStack, NewCar); -- push ford1 at the rear
   put_line("Inserting a ford with 2 doors");
   NewCar := new Car'(AbstractStackElement with 2, "Ford"); -- Heap allocation!
   PushTop(VehicleStack, NewCar); -- push ford2 at the rear
   put_line("Inserting a GMC with 2 doors");
   NewCar := new Car'(AbstractStackElement with 2, "GMC "); -- Heap allocation!
   PushBot(VehicleStack, NewCar); -- push GMC1 at the rear
   put_line("Inserting a RAM with 2 doors");
   NewCar := new Car'(AbstractStackElement with 2, "RAM "); -- Heap allocation!
   PushBot(VehicleStack, NewCar); -- push Ram1 at the rear
   put_line("Inserting a Chev with 3 doors");
   NewCar := new Car'(AbstractStackElement with 3, "Chev"); -- Heap allocation!
   PushTop(VehicleStack, NewCar); -- push Chevy1 at the rear

   new_line;
   put("stack size is: ");put(Integer'Image(StackSize(VehicleStack.all)));
   new_line;

   -- NewPlane := new Plane'(AbstractStackElement with 2, 3, "Boeing"); -- in heap!
   -- PushTop(VehicleStack, NewPlane); --push Boeing to front


  -- can't use the same stack multiple times yet because it breaks
   put_line("removing the first ford");
   for I in 1..StackSize(VehicleStack.all)
    loop
      VehiclePt := pop(VehicleStack);
      if VehiclePt.all in Car
       then -- ** Identify class of object at run time.
         IdentifyVehicle(Car'Class(VehiclePt.all));
         correctMake := IdentifyMake(Car(VehiclePt.all), "Ford");
         if correctMake = true and tempKnt = 0 then -- if it fits, then don't push it back, else put it back.
            tempKnt := tempKnt + 1;
         else
            PushTop(TempStack,VehiclePt); --put it  in temp stack
         end if;
      elsif VehiclePt.all in Plane
       then
         IdentifyVehicle(Plane'Class(VehiclePt.all));
         correctMake := IdentifyMake(Plane(VehiclePt.all), "Ford    ");
         if correctMake = true and tempKnt = 0 then -- if it fits, then don't push it back, else put it back.
            tempKnt := tempKnt + 1;
         else
            PushTop(TempStack,VehiclePt); --put it  in temp stack
         end if;
      end if;
      --PushTop(TempStack,VehiclePt); --put it  in temp stack
      new_line;
   end loop;
   tempKnt := 0;

   new_line;
   put("stack size is now: ");put(Integer'Image(StackSize(TempStack.all)));
   new_line;

-- put them back and re-label them
   for I in 1..StackSize(TempStack.all)
    loop
      VehiclePt := pop(TempStack);
      if VehiclePt.all in Car
       then -- ** Identify class of object at run time.
         IdentifyVehicle(Car'Class(VehiclePt.all));
      elsif VehiclePt.all in Plane
       then
         IdentifyVehicle(Plane'Class(VehiclePt.all));
      end if;
      PushTop(VehicleStack,VehiclePt); --put it back in Vehicle stack
      new_line;
   end loop;

   new_line;
   put("stack size is now: ");put(Integer'Image(StackSize(VehicleStack.all)));
   new_line;

   for I in 1..StackSize(VehicleStack.all)
    loop
      VehiclePt := pop(VehicleStack);
      if VehiclePt.all in Car
       then -- ** Identify class of object at run time.
         IdentifyVehicle(Car'Class(VehiclePt.all));
      elsif VehiclePt.all in Plane
       then
         IdentifyVehicle(Plane'Class(VehiclePt.all));
      end if;
      PushTop(TempStack,VehiclePt); --put it  in temp stack
      new_line;
   end loop;


--put it back in Vehicle stack before putting the planes in
   for I in 1..StackSize(TempStack.all)
    loop
      VehiclePt := pop(TempStack);
      PushTop(VehicleStack,VehiclePt);
      new_line;
   end loop;

   Put_line("Pushing Planes Now");
   put_line("Inserting a Boeing with 3 doors, 6 engines");
   NewPlane := new Plane'(AbstractStackElement with 3, 6, "Boeing  "); -- in heap!
   PushTop(VehicleStack, NewPlane); --push Boeing to front
   put_line("Inserting a Piper with 2 doors, 1 engine");
   NewPlane := new Plane'(AbstractStackElement with 2, 1, "Piper   "); -- in heap!
   PushTop(VehicleStack, NewPlane); --push Boeing to front
   put_line("Inserting a Cessna with 4 doors, 4 engines");
   NewPlane := new Plane'(AbstractStackElement with 4, 4, "Cessna  "); -- in heap!
   PushTop(VehicleStack, NewPlane); --push Boeing to front


-- put them back and re-label them
   for I in 1..StackSize(VehicleStack.all)
   loop
      VehiclePt := pop(VehicleStack);
      if VehiclePt.all in Car
      then -- ** Identify class of object at run time.
         IdentifyVehicle(Car'Class(VehiclePt.all));
      elsif VehiclePt.all in Plane
      then
         IdentifyVehicle(Plane'Class(VehiclePt.all));
      end if;
      new_line;
   end loop;



end UAbstStc;