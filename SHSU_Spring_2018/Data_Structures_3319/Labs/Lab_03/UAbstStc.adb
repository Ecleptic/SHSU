-- --in file UAbstStc.adb: place cars in the stack.
-- with Ada.Text_IO; use Ada.Text_io;
-- with AbstStck; use AbstStck;
-- with MakeCar; use MakeCar;
--
-- procedure UAbstStc is
--    type Stack_Ptr is access AbstractStack;
--    CarStack: Stack_Ptr := new AbstractStack;
--    StackPoint: Stack_Ptr;
--    NewCar, CarPt: AbstractStackElementPtr;
-- begin --Create 1st car.
--    NewCar := new Car'(AbstractStackElement with 4, "Ford"); --Heap allocation
--    push(CarStack, NewCar);
--
--    NewCar := new Car; -- Create 2nd car.
--    AssignNumDoors(Car'Class(NewCar.All), 2);
--    AssignManufacturer(Car'Class(NewCar.all), "Chev");
--
--    push(CarStack, NewCar);
--    NewCar := new Car; -- Create 3rd car.
--    AssignNumDoors(Car'Class(NewCar.All), 2); -- Default manufacturer to "GMC ".
--    push(CarStack, NewCar);
--    for I in 1..StackSize(CarStack.all)
--    loop
--       CarPt := pop(CarStack);
--       PrintManufacturer(Car'Class(CarPt.All));
--       PrintNumDoors(Car'Class(CarPt.All));
--       new_line;
--    end loop;
-- end UAbstStc;

--------------------------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_io;
with AbstStck; use AbstStck;
with MakeCar, MakePlane; use MakeCar, MakePlane;

procedure UAbstStc is
   type Stack_Ptr is access AbstractStack;
   VehicleStack: Stack_Ptr := new AbstractStack;
   StackPoint: Stack_Ptr;
   NewCar,CarPt, NewPlane, PlanePt, VehiclePt: AbstractStackElementPtr;
begin

   NewCar := new Car'(AbstractStackElement with 4, "Ford"); -- Heap allocation!
   push(VehicleStack, NewCar); -- 1st car.

   NewPlane := new Plane'(AbstractStackElement with 2, 2, "Northrup"); -- in heap!
   push(VehicleStack, NewPlane); --1st plane.

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