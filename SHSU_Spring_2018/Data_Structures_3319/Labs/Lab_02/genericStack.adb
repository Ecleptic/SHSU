
package body genericStack is



   ------------------------
   -- Reallocate Storage Algorithm
   ------------------------
   function reallocate(stackspace: in out namesArray;
      stackNum: in out integer;
      name: Unbounded_String)
      return boolean is
      availSpace :integer;
      totalInc: integer;
      GrowthAllocate : float;
      equalAllocate : float := 0.87;
      j: integer := base'Last-1;
      type stack is array(Integer range <>) of float;

      alpha: float;
      beta: float;
      sigma: float;
      tau: float := 0.0;

   begin

      availSpace := totalMemory - l0;
      totalInc := 0;

      -- ReA1:
      -- avail space is the total memory - top of stack N to base of stack N
      put("availSpace: "); put(Integer'Image(availSpace));
      new_line;
      put("top at: ");put(Integer'Image(top(j)));
      new_line;
      put("bottom at: "); put(Integer'Image(base(j)));
      new_line;
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
         put_line("memory overflowed. ending");
         return false;
      end if;
      -- ReA3
      GrowthAllocate := 1.0 - equalAllocate;
      alpha := float(equalAllocate) * float(availSpace)/float(stackNum);
      -- ReA4
      beta := float(GrowthAllocate) * float(availSpace) / float(totalInc);
      -- ReA5
      newBase(1) := base(1);
      sigma := float(0);
      for p in 2..numStacks loop
         tau := sigma + alpha + float(growth(p-1))*beta;
         put(float'image(tau));
         newBase(p) := newBase(p-1) + top(p-1) - Base(p-1) + Integer(Float'Floor(tau)) - integer(Float'Floor(sigma));
         sigma := tau;
      end loop;
      -- ReA6
      Top(stackNum) := Top(stackNum) - 1;
     -- perform movestack
      move(stackspace, growth, Top, Base, stackNum);
      Top(stackNum) := Top(stackNum) + 1;
     -- insert overflow item into top[k]
      stackspace(Top(stackNum)) := name;
      for J in 1..numStacks loop
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
    newBase: intArray;
    Top: in out intArray;
    Base: in out intArray;
    n: integer) is

      ddelta :integer;

   begin
      put("move please" & integer'image(n));
      For J in 2..N
         loop
         If newBase(j) < Base(j) then
            dDelta := Base(j) - newBase(j);
            For L in Base(j) + 1.. Top(j)
               loop
               StackSpace(l - ddelta) := StackSpace(l);
            End loop;
            Base(j) := newBase(j);
            Top(j) := Top(j) - dDelta;
         End If;
      End Loop;

         -- MoA2
      For J in reverse 2..N
         loop
         If newBase(j) > Base(j) then
            dDelta := newBase(j) - Base(j);
            For l in reverse (Base(J)+1)..Top(J)
            loop
               StackSpace(l + ddelta) := StackSpace(l);
            End loop;
            Base(j) := newBase(j);
            Top(j) := Top(j) + dDelta;
         End If;
      End Loop;
   end move;


   ------------------------
   -- Push onto Stack
   ------------------------
   function push( stackNum: in integer;
                  name: in Unbounded_String) return boolean is
   begin
      -- increment up one before starting
      top(stackNum) := top(stackNum) + 1;
      -- if full, return false and overflow
      put("stackNum: "); put(Integer'Image(stackNum));
      new_line;
      put("top at: ");put(Integer'Image(top(stackNum)));
      new_line;
      put("bottom at: "); put(Integer'Image(base(stackNum+1)));
      new_line;

      if top(stackNum) > base(stackNum+1) then
         put_line("stack overflow at stack " & Integer'Image(stackNum));
         new_line;
         return false;
      else
         put("Inserting " & To_String(name)& " into stack number " & Integer'Image(stackNum) & " at stack location" & Integer'Image(top(stackNum)) );
         New_Line;
         stackspace(top(stackNum)) := name;
         return true;
      end if;
   end push;

   ------------------------
   -- Pop From Stack
   ------------------------
   procedure pop(stackNum: in integer) is
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
