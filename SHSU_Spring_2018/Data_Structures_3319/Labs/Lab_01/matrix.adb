with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Matrix is

   N : INTEGER := 10;
   Dummy1 : array(INTEGER range 1..7) of BOOLEAN;
   Dummy2 : array(INTEGER range -21..N) of BOOLEAN;
   Dummy3 : array(-21..N) of BOOLEAN;

   type MY_ARRAY is array(1..5) of INTEGER;

   Total        : MY_ARRAY;
   First        : MY_ARRAY;
   Second       : MY_ARRAY;
   Funny        : array(1..5) of INTEGER;
   X,Y          : array(12..27) of INTEGER;
   Fourth_Value : INTEGER renames First(4);

begin
   First(1) := 12;
   First(2) := 16;
   First(3) := First(2) - First(1);
   Fourth_Value := -13;
   First(5) := 16 - 2 * First(2);

   for Index in 1..5 loop
      Second(Index) := 3 * Index + 77;
   end loop;

   Total := First;
   if Total = First then
      Put("Both arrays are the same size and contain ");
      Put_Line("the same values in all elements.");
   end if;

   for Index in 1..5 loop
      Total(Index) := Total(Index) + Second(Index);
      Funny(Index) := Total(Index) + First(6 - Index);
      Put("The array values are");
      Put(Total(Index), 6);
      Put(Funny(Index), 6);
      New_Line;
   end loop;
end Matrix;




-- Result of execution

-- Both arrays are the same size and contain the same values in...
-- The array values are    92    76
-- The array values are    99    86
-- The array values are    90    94
-- The array values are    76    92
-- The array values are    76    88
