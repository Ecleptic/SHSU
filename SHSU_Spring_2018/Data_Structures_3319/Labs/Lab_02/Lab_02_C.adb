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


procedure Lab_02_C is

    totalMemory: integer := 27;
    numStacks: integer := 4;
    l0: integer := 4;
    m: integer := 27;
    N : integer := numStacks;
    --  fullStack: array(-11..60) of integer;
    availSpace:integer  := m - l0;
    Totallnc: integer := 0;
    J:integer := N;
  --  base(j) := integer(float'floor((float(j - 1) / float(numStacks)) * float((totalMemory)))) + l0;

    OldTop: array(-11..60) of integer;
    Growth: array(-11..60) of integer;
    NewBase: array(-11..630) of integer;


availSpace: integer;
		totalInc: integer := 0;
		minSpace: integer := floor(0.05*(float(M) - float(L)));
		J: integer := N;
		alpha: float;
		beta: float;
		sigma: float;
		tau: float;
		temp: integer;
        Top: in out intArray; L: integer; M: integer; N: integer; K: integer; input: NameType) return boolean is

	begin
		if minSpace = 0 then
			minSpace := 1;
		end if;
		availSpace := M - L;
		while J > 0 loop
			availSpace := availSpace - (Top(J) - Base(J));
			if Top(J) > Info(J) then
				Info(J) := Top(J) - Info(J);
				totalInc := totalInc + Info(J);
			else
				Info(J) := 0;
			end if;
			J := J - 1;
		end loop;
		if availSpace < (minSpace - 1) then
			put("OUT OF MEMORY, terminating program...");
			return false;
		end if;
		alpha := 0.15 * float(availSpace) / float(N);
		beta := 0.85 * float(availSpace) / float(totalInc);
		sigma := 0.0;
		temp := Info(1);
		Info(1) := Base(1);
		for J in 2..N loop
			tau := sigma + alpha + float(temp)*beta;
			temp := Info(J);
			Info(J) := Info(J-1) + Top(J-1) - Base(J-1) + floor(tau) - floor(sigma);
			sigma := tau;
		end loop;
		Top(K) := Top(K) - 1;
		movestack(StackSpace, Info, Top, Base, N);
		Top(K) := Top(K) + 1;
		StackSpace(Top(K)) := input;
		for J in 1..N loop
			Info(J) := Top(J);
		end loop;
		return true;



























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
      declare
         type stack is array(-11..60) of string;
      begin
         put("oh dang");
      end;
--      Base[J] := Top[J] = floor((J-1)/N*<) + L0

   ------------------------
   -- Reallocate Storage Algorithm
   ------------------------

   -- ReA1:
   -- avail space is the total memory - top of stack N to base of stack N

   While J > 0
   loop
       availSpace := availSpace - (Top[J]- Base[J]);
       If Top[J] > OldTop[J] then
           Growth[J] := Top[J] - OldTop[J];
           Totallnc := Totallnc + Growth[J];
       Else
           Growth[J] := 0;
       End If;
       J := J - 1;
   End loop;
--
--   -- ReA2
--   If availSpace < (minSpace - 1) then
--       put("Insufficient memory for re-packing");
--   End If;
--
--   -- ReA3
--   GrowthAllocate := 1 - EqualAllocate;
--   alpha := EqualAllocate * availSpace / N;
--
--   -- ReA4
--   beta := GrowthAllocate * availSpace / N;
--
--   -- ReA5
--   NewBase[1] := Base[1];
--   sigma := 0;
--   For J := 2..N
--   loop
--       tau := sigma + alpha + Growth[J - 1] * beta;
--       NewBase[J] := NewBase[J - 1] + (Top[J - 1] - Base[J - 1]) floor(tau) - floor(sigma);
--       sigma := tau;
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


function reallocate(StackSpace: in out arrayType;
                          Info: in out intArray;
                          Base: in out intArray;
                          Top: in out intArray;
                                L: integer;
                                M: integer;
                                N: integer;
                                K: integer;
                                input: NameType)
                        return boolean is


	end reallocate;


















end Lab_02_C;
