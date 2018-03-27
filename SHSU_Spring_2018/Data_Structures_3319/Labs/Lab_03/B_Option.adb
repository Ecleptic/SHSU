-----------------------------------------------------------
-- Lab 03 Program
-- B-Option
-- Cameron Green
-----------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with CompStkg;
with Unchecked_Conversion;


procedure B_Option is
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   type MonthName is (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec); -- Enumeration type.
   package MonthNameIO is new -- Ada generates i/O routines.
         Ada.Text_IO.Enumeration_IO(MonthName);
   use MonthNameIO;
   type Date is record
         Month: MonthName;
         Day: Integer range 1..31; -- Limits range.
         Year: Integer; -- No limit on range.
      end record;

   procedure PrintDate(aDate: Date) is
   begin
      put("mmm/dd/yyyy is ");
      put(aDate.Month);
      put("/");
      put(aDate.Day,2);
      put("/");
      put(aDate.Year,4);
   end PrintDate;

   type carMakes is (Ford, GMC, RAM, Chevy,  Boeing, Piper, Cesna); -- Enumeration type.


   type car is tagged record
         make: carMakes;
         doors: integer range 1..4;
         -- postition: Unbounded_String; -- where in the list to put it.
      end record;

   type plane is new car with record
         engines: integer range 1..6;
      end record;

   A := Date
begin

   PrintDate();

   put_line("hi");

end B_Option;