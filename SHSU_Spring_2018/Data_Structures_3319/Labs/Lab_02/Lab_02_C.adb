-----------------------------------------------------------
-- Lab 02 Program
-- C-Option
-- Cameron Green
-----------------------------------------------------------
with gnat.Io; use gnat.Io;


procedure Lab_02_C is

   totalMemory: integer;
   numStacks: integer;

begin

   put_line("Total memory?");
   get(totalMemory);
   put_line("Number of stacks?");
   get(numStacks);

   new_line;
   put((totalMemory));
   new_line;
   put((numStacks));
   new_line;
   declare

      type stack is array(1..totalMemory) of character;
   begin
      put("oh dang");
   end;
end Lab_02_C;
