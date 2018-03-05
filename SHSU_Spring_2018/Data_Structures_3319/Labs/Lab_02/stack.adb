package body stack is  -- in file stack.adb
   max: constant := 100;      -- Data structures to create stack.
   s: array(1..max) of integer;
   top: integer range 0..max := 0;

   procedure push(x: integer) is
   begin
      top := top + 1;  s(top) := x;
   end push;

   procedure pop(x: out integer) is
   begin
      x := s(top);  top := top - 1;
   end pop;

begin
   top := 0; --initialize top of stack to empty
end stack;
