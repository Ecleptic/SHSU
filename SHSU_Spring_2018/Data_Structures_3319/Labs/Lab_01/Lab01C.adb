-----------------------------------------------------------
-- Hello World program
-- C-Option
-- Cameron Green

-- Start with enumerating the a..j
-- figure out warshall
-- print it


-- for B create a library of warshall (.ads)


--
-- #7 should be the first character because that's the enumeration
-----------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with warshall; use warshall;
procedure Lab01C is
   -- arrayMatrix: array(Positive range <>, Positive range <>) of boolean;
   rowLen : integer := 6;
   arrayMatrix : array(1..rowLen+1) of character := ('A', 'B', 'C', 'D', 'J', 'K', 'L');

   inputCharacters: array(1..rowLen*2) of character := (('A','B'),('B','D'),('C','B'),('B','C'),('J','K'),('J','L'));
   computedCharacters : warshall.inChars(1..rowLen,1..rowLen);

   N : integer := 1;
   isTrue: boolean := false;
--   size: integer;


----------
-- Print array
----------
begin
   -- print top row
   put("     ");          -- 7 spaces
   for i in 1..rowLen +1
    loop
      put(arrayMatrix(i));
      put("     ");          -- 8 spaces
   end loop;

   new_Line;
   -- print initial matrix
   for i in 1..rowLen +1 -- loop rows
    loop
      put(arrayMatrix(i)); -- print label i
      put("    ");
      for j in 1..rowLen+1 -- loop columns
        loop
         -- put("0");
         N := 1;

         while N < rowLen*2
             loop
            if arrayMatrix(i) = computedCharacters(N) and arrayMatrix(j) = computedCharacters(N+1) then
               isTrue := true;
            end if;
            N := N + 2;
         end loop;
         if(isTrue = true) then
            put("1");
         else
            put("0");
         end if;
         isTrue := false;
         put("     ");          -- 8 spaces
      end loop; -- end J loop
     -- new_Line;
      new_Line;
   end loop; -- end I loop

end Lab01C;




