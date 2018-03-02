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
with gnat.Io; use gnat.Io;


procedure Lab_02_C is

   totalMemory: integer;
   numStacks: integer;
   l0: integer := 4;
   m: integer := 27;
   fullStack: array(-11..60) of integer;
   -- OldTop;
   -- Growth;
   -- NewBase;

begin

   put_line("Total memory?");
   get(totalMemory);
   put_line("Number of stacks?");
   get(numStacks);

   new_line;
   put(totalMemory);
   new_line;
   put(numStacks);
   new_line;

--
--   ------------------------
--   -- Setup Stack
--   ------------------------
--      declare
--         type stack is array(1..totalMemory) of character;
--      begin
--         put("oh dang");
--      end;
--      Base[J] := Top[J] = floor((J-1)/N*<) + L0
--
--   ------------------------
--   -- Reallocate Storage Algorithm
--   ------------------------
--
--   -- ReA1:
--   -- avail space is the total memory - top of stack N to base of stack N
--   AvailSpace := Base[N+1] - Base[0];
--   Totallnc := 0;
--   J := N;
--   While J > 0
--   loop
--       AvailSpace := AvailSpace - (Top[J]- Base[J]);
--       If Top[J] > OldTop[J] then
--           Growth[J] := Top[J] - OldTop[J];
--           Totallnc := Totallnc + Growth[J];
--       Else
--           Growth[J] := 0;
--       End If;
--       J := J - 1;
--   End loop;
--
--   -- ReA2
--   If AvailSpace < (MinSpace - 1) then
--       put("Insufficient memory for re-packing");
--   End If;
--
--   -- ReA3
--   GrowthAllocate := 1 - EqualAllocate;
--   Alpha := EqualAllocate * AvailSpace / N;
--
--   -- ReA4
--   Beta := GrowthAllocate * AvailSpace / N;
--
--   -- ReA5
--   NewBase[1] := Base[1];
--   Sigma := 0;
--   For J := 2..N
--   loop
--       Tau := Sigma + Alpha + Growth[J - 1] * Beta;
--       NewBase[J] := NewBase[J - 1] + (Top[J - 1] - Base[J - 1]) floor(Tau) - floor(Sigma);
--       Sigma := Tau;
--   End loop;
--
--   -- ReA6
--   Top[K] := Top[K] - 1;
--   put("perform moveStack");
--   Top[K] := Top[K] + 1;
--   For J in 1..N
--   loop
--       OldTop[J] := Top[J];
--   End Loop;
--
--   ------------------------
--   -- MoveStack Algorithm
--   ------------------------
--   -- MoA1
--   For J in 2..N
--   loop
--       If NewBase[J] < Base[J] then
--           Delta := Base[J] - NewBase[J];
--           For L in (Base[J] + 1), (Base[J] + 2).. Top[J]
--           loop
--               StackSpace[L - Delta] := StackSpace[L];
--           End loop;
--           Base[J] := NewBase[J];
--           Top[J] := Top[J] - Delta;
--       End If;
--   End Loop;
--
--   -- MoA2
--   For J in N..2
--   loop
--       If NewBase[J] > Base[J] then
--           Delta := NewBase[J] - Base[J];
--           For L in Top[J], (Top[J]-1), ... (Base[J] + 1)
--           loop
--               StackSpace[L + Delta] := StackSpace[L];
--           End loop;
--           Base[J] := NewBase[J];
--           Top[J] := Top[J] + Delta;
--       End If;
--   End Loop;
--
--   ------------------------
--   -- Insert into stack K
--   ------------------------
--   --  Top[K] := Top[K] + 1;
--   --  If Top[K] > Base[K + 1] then
--   --      put("overflow!");
--   --  else
--   --      StackSpace[Top[K]] := Y; -- Insert Y into stack
--   --  End If;
--   --
--   ---------------------
--   -- Delete from stack K
--   ---------------------
--   --  If Top[K] = Base[K] then
--   --      put("Underflow");
--   --  Else
--   --      Y := StackSpace[Top[K]]; -- remove top item in stack and assign to Y
--   --      Top[K] := Top[K] - 1;
--   --  End If;
--   --
--   --
end Lab_02_C;
