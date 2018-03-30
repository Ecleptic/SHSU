-----------------------------------------------------------
-- Lab 03 Program
-- B-Option
-- Cameron Green
-----------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with CompStkg;
with AbstStck;
with Unchecked_Conversion;


procedure B_Option is
   type carMakes is (Ford, GMC, RAM, Chevy,  Boeing, Piper, Cesna); -- Enumeration type.
   type planeMakes is (Ford, GMC, RAM, Chevy,  Boeing, Piper, Cesna); -- Enumeration type.
   type vehicle is  tagged record
         doors: integer range 1..4;
      end record;


   type car is new vehicle with record
         make: carMakes;
      end record;


   type plane is new vehicle with record
         make: planeMakes;
         engines: integer range 1..6;
      end record;

begin

   put_line("hi");

end B_Option;