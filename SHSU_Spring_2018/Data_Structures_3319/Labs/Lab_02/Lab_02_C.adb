-----------------------------------------------------------
-- Lab 02 Program
-- C-Option
-- Cameron Green

-- Steps: (I think)
-- 1) Prompt for Total Memory and number of stacks
-- 2) Divide equally between stacks *before* processing transactions
-- 3) Print contents of stacks as they're processed

--  1 array sized from -11 to 60 then
-- by input then make a # of pointers th where each stack starts and ends

-- Notes Pg. 22ish
-- pgmNotes pg 50ish

--
-----------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
with genericStack; use genericStack;
-- with Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Unchecked_Conversion;




procedure Lab_02_C is
   function StringToCharacter is new Unchecked_Conversion(String, Character);

   inFile: File_Type;
   totalMemory: integer := 27;
   numStacks: integer := 4;
   l0: integer := 4;
   m: integer := 27;
   N : integer := numStacks;
   upper : integer := 24;
   lower: integer := 4;
   name : Unbounded_String;
   stackNum : integer;
   top : genericStack.intArray (1..N);
   base : genericStack.intArray (1..N+1);
   op : character;
   didPush : boolean;
	-- new stack := genericStack;

   type stack is array(Integer range <>) of Unbounded_String;

begin

   begin
      Open (File => inFile,
         Mode => In_File,
         Name => "in.txt");

      loop
         exit when End_Of_File (inFile);
         new_line(3);
         -- loop
         put_line("get operand");
         op := StringToCharacter(get_line(inFile));

         -- pop from stack
         if op = 'D' then
            	-- pop name from stack
            stackNum := Integer'Value(get_line(inFile));
            put("Popping from stack number ");put(Integer'Image(stackNum));
            new_line;
         end if;
         if op = 'I' then
            put("got "& op);
            new_line;

            -- push into stack
            stackNum := Integer'Value(get_line(inFile));
            put("stackNum: ");put(Integer'Image(stackNum));
            new_line;

            name := To_Unbounded_String(get_line(inFile));
            put("name: ");put(To_String(name));
            new_line;

            didPush := push (stackNum, name);



         end if;

         if end_of_file(inFile) then
            new_line;
            put_line("DONE");
         end if;
         -- end loop;
      end loop;

      Close (inFile);
   end;
























--  put_line("Total memory?");
--  get(totalMemory);
--  put_line("Number of stacks?");
--  get(numStacks);

--  new_line;
--  put(totalMemory);
--  new_line;
--  put(numStacks);
--  new_line;


   ------------------------
   -- Setup Stack
   ------------------------
 --  declare
 --     type stack is array(-11..60) of string;
 --  begin
 --     put("oh dang");
 --  end;
--      Base[J] := Top[J] = Float'Floor((J-1)/N*<) + L0







end Lab_02_C;
