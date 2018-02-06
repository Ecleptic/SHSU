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

with Ada.Text_IO, warshall; use Ada.Text_IO, warshall;
procedure Lab01C is
   type matrix is array(integer range <>, integer range <>) of boolean;

   inFile : File_Type;
   outFile : File_Type;
   rowLen : integer := 6;
   inputCharacters: array (1..rowLen*2) of character;
   bmr : matrix (1..rowLen, 1..rowLen);
   N,I,J,K: integer := 1;
   isTrue: boolean := false;


----------
-- Print array
----------
begin
   Open (File => inFile,
         Mode => In_File,
         Name => "in.txt");
   Create (File => outFile,
      Mode => Out_File,
      Name => "out.txt");

   loop

      exit when End_Of_File (inFile);

    --  inputCharacters(I):=(Get_Line(inFile));
      Put_Line (Get_Line (inFile));
      -- Put_Line(outFile,Get_Line (inFile));

   end loop;

   Close (inFile);

end Lab01C;