-- in file CompStk1.ads
-- Exports IntIO, MonthName, MonthNmaeIO, Date and PrintDate. with Ada.Text_IO; use Ada.Text_IO;
package CompStk1 is
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

procedure PrintDate(aDate: Date);

end CompStk1;

--in file CompStk1.adb package body CompStk1 is
procedure PrintDate(aDate: Date) is
begin
    put("mmm/dd/yyyy is ");
    put(aDate.Month);
    put("/");
    put(aDate.Day,2);
    put("/");
    put(aDate.Year,4);
    end PrintDate;
end CompStk1;
