-----------------------------------------------------------
-- Lab 01 program
-- B-Option
-- Cameron Green

-- Start with enumerating the a..j
-- figure out warshall
-- print it


-- for B create a library of warshall (.ads)


--
-- #7 should be the first character because that's the enumeration
-----------------------------------------------------------

with Ada.Text_IO, warshall;
use Ada.Text_IO, warshall;
-- change string to char.
with Unchecked_Conversion;
-- use Unchecked_Conversion;



procedure Lab01B is
   function StringToCharacter is new Unchecked_Conversion(String, Character);
   inFile, outFile: File_Type;

   -- rowLen : integer := 6;     -- need to get from prompt

  -- computedCharacters : warshall.inChars(1..rowLen,1..rowLen);


   N : integer := 1;
   isTrue: boolean := false;
--   size: integer;



----------
-- get length
----------
   function getRowLen return integer is
      len : integer;

   begin
      Open (File => inFile,
         Mode => In_File,
         Name => "in.txt");
      len := Integer'Value(Get_Line (inFile));

      Close (inFile);
      return len;

   end getRowLen;


   rowLen : integer := getRowLen;
   type myArray is array(1..rowLen*2) of character;


----------
-- get arrray matrix from file
----------
   function getMatrixFromFile return myArray is
      inputCharacters : myArray;
      i : integer := 1;
      temp:string(1..1);
   begin
      Open (File => inFile,
         Mode => In_File,
         Name => "in.txt");
      Set_Line (inFile, To => 2);

      loop
         exit when End_Of_File (inFile);
         temp := Get_Line (inFile);
         inputCharacters(i) := StringToCharacter(temp);
         i := i + 1;
      end loop;

      Close (inFile);
      return inputCharacters;
   end getMatrixFromFile;



-- set variables

   bMatrix : warshall.matrix (1..rowLen, 1..rowLen); -- has to be the same type as the one in warshall

   arrayMatrix : array(1..rowLen) of character := ('A', 'B', 'C', 'D', 'J', 'K', 'L');
   inputCharacters : myArray := getMatrixFromFile;
   -- inputCharacters: array(1..rowLen*2) of character := ('A','B','B','D','C','B','B','C','J','K','J','L');
----------
-- Print array and create bMatrix.
----------
begin
   put("Input: ");
   new_Line;
   -- print top row
   put("     ");          -- 5 spaces
   for i in 1..rowLen
    loop
      put(arrayMatrix(i));
      put("     ");          -- 5 spaces
   end loop;

   new_Line;
   -- print initial matrix
   for i in 1..rowLen -- loop rows
      loop
      put(arrayMatrix(i)); -- print label i
      put("    ");          -- 4 spaces
      for j in 1..rowLen -- loop columns
          loop
          -- put("0");
         N := 1;

         while N < rowLen*2
              loop
            if arrayMatrix(i) = inputCharacters(N) and arrayMatrix(j) = inputCharacters(N+1) then
               isTrue := true;
            end if;
            N := N + 2;
         end loop;
         if(isTrue = true) then
            put("1");
            bMatrix(i,j) := true; --setup bMatrix.
         else
            put("0");
            bMatrix(i,j) := false;
         end if;
         isTrue := false;
         put("     ");          -- 5 spaces
      end loop; -- end J loop
      -- new_Line;
      new_Line;
   end loop; -- end I loop
   new_Line(3);

----------
-- Run warshalls on bMatrix!
----------
   warshallFunc(bMatrix);


----------
-- Write and Print Output
----------

   Create (File => outFile,
      Mode => Out_File,
      Name => "out.txt");

   put("     ");          -- 5 spaces
   put(outFile,"     ");          -- 5 spaces
   for i in 1..rowLen
    loop
      put(outFile,arrayMatrix(i)); -- print column labels
      put(outFile,"        ");          -- 8 spaces
   end loop;
   new_Line;
   put_line(outFile," "); --new line on output text

   for i in 1..rowLen  -- loop rows
      loop
      put(outFile,arrayMatrix(i)); -- print row label
      put(outFile,"    ");          -- 4 spaces
      for j in 1..rowLen -- loop columns
      loop
         if bMatrix(i,j) = true then
            put("1");
            put(outFile,"1");
         else
            put("0");
            put(outFile,"0");

         end if;
        -- put(outFile,boolean'Image(bMatrix(i,j)));
        --  -- True has less letters than False, so make sure we print more spaces behind it.
        --  if bMatrix(i,j) = true then
         put(outFile,"     ");          -- 5 spaces
        --  else
        --     put(outFile,"    ");          -- 4 spaces
        --  end if;

        --  put(Boolean'Image(i));
         -- put(Boolean'Image(j));
      end loop; -- end J loop
      new_Line(2);
      put_line(outFile," ");  --new line on output text
   end loop; -- end I loopend Lab01B;


end Lab01B;