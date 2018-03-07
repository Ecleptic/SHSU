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
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Unchecked_Conversion;



procedure Lab_02_C is
   function StringToCharacter is new Unchecked_Conversion(String, Character);

   inFile: File_Type;
   m: integer := 27;
   N : integer := numStacks;
   name : Unbounded_String;
   stackNum : integer;
   op : character;
   didPush : boolean;
   didAllocate : boolean;


begin

   begin
      for i in 1..numStacks
      loop
         base(i) := integer(Float'Floor((Float(i - 1) / Float(numStacks)) * Float((totalMemory-l0)))) + (l0);
         put("base at " & integer'image(i));
         put(integer'image(base(i)));
         top(i) := base(i);
         oldTop(i) := top(i);
         new_line;
      end loop;
      base(numStacks + 1) := totalMemory + l0 - 1;



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
            put("Popping");
            new_line;
            pop(stackNum);


         	--TODO: BASES AND TOPS
         	--print results
         	-- bases
            put("base addresses: "&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(base(r)));
               put(Character'Val (9));
            end loop;
            new_line;

         	-- tops
            put("top addresses: "&Character'Val (9)&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(top(r)));
               put(Character'Val (9));
            end loop;
            new_line;

         	-- oldTops
            put("oldTop addresses: "&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(oldTop(r)));
               put(Character'Val (9));
            end loop;
            new_line;
         		--loop accross stacks
            for r in 1..numStacks
            	loop
               new_line;
               put("stack number ");
               put(Integer'image(r));
               new_line;
               put("Address" &Character'Val (9)& "Name");
               new_line;
               put("-------------------");
               new_line;
               for j in base(r)+1..top(r)
               	loop
                  put(integer'image(j));
                  put("   " & Character'Val (9));
                  put(To_String(stackspace(j)));
                  new_line;
               end loop;
               put("_________________");
               new_line;
            end loop;
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
            if(didPush = false) then
               put_line("could not push. Reallocating.");
               didAllocate := reallocate(stack,stackNum, name);
               if(didAllocate = false) then
                  -- end program
                  put_line("could not reallocate. out of memory. Closing program;");
                  --ada.task_identification.abort_task(ada.task_identification.current_task); --mike used
                 -- Close(inFile);
               end if;
            end if;
         	--TODO: BASES AND TOPS
         	--print results
         	-- bases
            put("base addresses: "&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(base(r)));
               put(Character'Val (9));
            end loop;
            new_line;

         	-- tops
            put("top addresses: "&Character'Val (9)&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(top(r)));
               put(Character'Val (9));
            end loop;
            new_line;

         	-- oldTops
            put("oldTop addresses: "&Character'Val (9));
            for r in 1..numStacks
            loop
               put(Integer'image(oldTop(r)));
               put(Character'Val (9));
            end loop;
            new_line;
         		--loop accross stacks
            for r in 1..numStacks
            	loop
               new_line;
               put("stack number ");
               put(Integer'image(r));
               new_line;
               put("Address" &Character'Val (9)& "Name");
               new_line;
               put("-------------------");
               new_line;
               for j in base(r)+1..top(r)
               	loop
                  put(integer'image(j));
                  put("   " & Character'Val (9));
                  put(To_String(stackspace(j)));
                  new_line;
               end loop;
               put("_________________");
               new_line;
            end loop;
            new_line(2);



         end if;
         if end_of_file(inFile) then
            new_line;
            put_line("Finished");
         end if;
         -- end loop;
      end loop;

      Close (inFile);
   end;






end Lab_02_C;
