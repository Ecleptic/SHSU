
package body genericStack is



   ------------------------
   -- Reallocate Storage Algorithm
   ------------------------
   function reallocate(stackspace: in out namesArray;
      growth: in out intArray;oldTop: in out intArray;
      newBase: in out intArray;
      Base: in out intArray;
      Top: in out intArray;
      l0: integer;
      M: integer;
      N: integer;
      K: integer;
      input: Unbounded_String)
      return boolean is


      totalMemory: integer := 27;
      numStacks: integer := 4;
     -- l0: integer := 4;
     -- m: integer := 27;
     -- n: integer  := numStacks;
      availSpace :integer;
      totalInc: integer;
      GrowthAllocate : float;
      equalAllocate : float := 0.87;
      j: integer;
      -- k: integer;
      type stack is array(Integer range <>) of float;

      minSpace : integer := m - l0;
      --  J: integer := N;
      alpha: float;
      beta: float;
      sigma: float;
      tau: float;
      temp: integer;
      --  Top:= growth (1..N);

   begin

      availSpace := m - l0;
      totalInc := 0;
      j := N;

      -- ReA1:
      -- avail space is the total memory - top of stack N to base of stack N
      while J > 0 loop
         availSpace := availSpace - (top(J) - base(J));
         if top(J) > oldTop(J) then
            growth(J) := top(J) - oldTop(J);
            totalInc := totalInc + growth(J);
         else
            growth(J) := 0;
         end if;
         J := J - 1;
      end loop;
      -- ReA2
      if availSpace < (minSpace - 1) then
         put("memory overflowed. ending");
         return false;
      end if;
      -- ReA3
      GrowthAllocate := 1.0 - equalAllocate;
      alpha := float(equalAllocate) * float(availSpace)/float(n);
      -- ReA4
      beta := float(GrowthAllocate) * float(availSpace) / float(totalInc);
      -- ReA5
      newBase(1) := base(1);
      sigma := float(0);
      for J in 2..N loop
         tau := sigma + alpha + float(growth(j-1))*beta;
         newBase(J) := newBase(J-1) + top(J-1) - Base(J-1) + Integer(Float'Floor(tau)) - integer(Float'Floor(sigma));
         sigma := tau;
      end loop;
      -- ReA6
      Top(K) := Top(K) - 1;
     -- perform movestack
     -- movestack(StackSpace, Info, Top, Base, N);
      Top(K) := Top(K) + 1;
     -- insert overflow item into top[k]
      stackspace(Top(K)) := input;
      for J in 1..N loop
         oldTop(J) := Top(J);
      end loop;
      return true;
   end reallocate;

   ------------------------
   -- MoveStack Algorithm
   ------------------------
   -- MoA1
   procedure move(
    stackspace: in out namesArray;
    growth: intArray;
    Top: in out intArray;
    Base: in out intArray;
    n: integer) is

   begin
      put("move please");

   --      For J in 2..N
   --   loop
   --       If NewBase(j) < Base(j) then
   --           Delta := Base(j) - NewBase(j);
   --           For L in (Base(j) + 1), (Base(j) + 2).. Top(j)
   --           loop
   --               StackSpace(l - delta) := StackSpace(l);
   --           End loop;
   --           Base(j) := NewBase(j);
   --           Top(j) := Top(j) - Delta;
   --       End If;
   --   End Loop;
   --
   --   -- MoA2
   --   For J in N..2
   --   loop
   --       If NewBase(j) > Base(j) then
   --           Delta := NewBase(j) - Base(j);
   --           For L in Top(j), (Top(j)-1), ... (Base(j) + 1)
   --           loop
   --               StackSpace(l + delta) := StackSpace(l);
   --           End loop;
   --           Base(j) := NewBase(j);
   --           Top(j) := Top(j) + Delta;
   --       End If;
   --   End Loop;
   end move;


   ------------------------
   -- Push onto Stack
   ------------------------
   function push( stackspace: in out namesArray;
                  top: in out intArray;
                  base: in out intArray;
                  stackNum: in integer;
                  name: in Unbounded_String) return boolean is
   begin
      -- increment up one before starting
      top(stackNum) := top(stackNum) + 1;
      -- if full, return false and overflow
      if (top(stackNum) > base(stackNum + 1)) then
         put_line("stack overflow at " & Integer'Image(stackNum));
         new_line;
         return false;
      else
         put("Inserting into stack number " & To_String(name));
         put(Integer'Image(stackNum));
         put("at stack location" & Integer'Image(top(stackNum)) );
         New_Line;
         stackspace(top(stackNum)) := name;
         return true;
      end if;
   end push;
   ------------------------
   -- Pop From Stack
   ------------------------
   procedure pop( stackspace: in out namesArray;
                  top: in out intArray;
                  base: in out intArray;
                  stackNum: in integer) is
   begin
      if top(stackNum) = base(stackNum) then
         put_line("stack underflow" & Integer'Image(stackNum));
      else
         put("popping from stack number " & Integer'Image(stackNum) & " " & To_String(stackspace(top(stackNum))));
         New_Line;
         stackspace(top(stackNum)) := to_unbounded_string("empty space");
         top(stackNum) := top(stackNum) - 1;
      end if;
   end pop;



end genericStack;
