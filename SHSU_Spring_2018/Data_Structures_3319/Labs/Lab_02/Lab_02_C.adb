-----------------------------------------------------------
-- Lab 02 Program
-- C-Option
-- Cameron Green
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
   currentStackNumber : integer;
   op : character;
   didPush : boolean;
   didAllocate : boolean;


begin

   Open (File => inFile,
         Mode => In_File,
         Name => "in.txt");
  -- put("number of stacks:");
  -- numStacks := Integer'Value(Get_Line (inFile));
  -- put("total Memory:");
  -- totalMemory := Integer'Value(Get_Line (inFile));
  -- put("upper Bound:");
  -- upper := Integer'Value(Get_Line (inFile));
  -- put("lower Bound:");
  -- lower := Integer'Value(Get_Line (inFile));
  -- put("l0:");
  -- l0 := Integer'Value(Get_Line (inFile));


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


      loop
         exit when End_Of_File (inFile);
         new_line;
         put_line("get operand");
         op := StringToCharacter(get_line(inFile));

         -- pop from stack
         if op = 'D' then
            -- pop name from stack
            currentStackNumber := Integer'Value(get_line(inFile));
            put_line("Popping");
            pop(currentStackNumber);

         end if;
         if op = 'I' then
            -- push into stack
            currentStackNumber := Integer'Value(get_line(inFile));

            name := To_Unbounded_String(get_line(inFile));
            --new_line;
            didPush := push (currentStackNumber, name);
            if(didPush = false) then
               put_line("could not push. Reallocating.");
               didAllocate := reallocate(currentStackNumber, name);
               if(didAllocate = false) then
                  -- end program
                  put_line("could not reallocate. out of memory. Closing program;");
                  --ada.task_identification.abort_task(ada.task_identification.current_task); --mike used
                  Close(inFile);
               end if;
            else
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

            end if; --closing print from didpush



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
