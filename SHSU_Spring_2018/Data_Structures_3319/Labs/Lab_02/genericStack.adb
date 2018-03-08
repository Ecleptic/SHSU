
package body genericStack is



   ------------------------
   -- Reallocate Storage Algorithm
   ------------------------
   function reallocate(currentStackNumber: in out integer; name: Unbounded_String) return  boolean is
      availSpace :integer;
      totalInc: integer;
      GrowthAllocate : float := 0.87;
      equalAllocate : float := 0.13;
      j: integer := numStacks;

      alpha: float;
      beta: float;
      sigma: float;
      tau: float := 0.0;

   begin


       -- ReA1:
       -- avail space is the total memory - top of stack N to base of stack N
      availSpace := totalMemory - l0;
      totalInc := 0;
      if minSpace = 0 then
         minSpace := 1;
      end if;


      put("availSpace: "); put(Integer'Image(availSpace));
      new_line;
      put("top at: ");put(Integer'Image(top(j)));
      new_line;
      put("bottom at: "); put(Integer'Image(base(j)));
      new_line;
      while J > 0
       loop
         availSpace := availSpace - (top(J) - base(J));
         if top(J) > oldTop(J)
          then
            growth(J) := top(J) - oldTop(J);
            totalInc := totalInc + growth(J);
         else
            growth(J) := 0;
         end if;
         J := J - 1;
      end loop;
       -- ReA2
      if availSpace < minSpace - 1
       then
         put_line("memory overflowed. ending");
         return false;
      end if;
       -- ReA3
      alpha := float(equalAllocate) * float(availSpace)/float(numStacks);
       -- ReA4
      beta := float(GrowthAllocate) * float(availSpace) / float(totalInc);
       -- ReA5
      newBase(1) := base(1);
      sigma := float(0);
      for p in 2..numStacks
       loop
         tau := sigma + alpha + float(growth(p-1))*beta;
         newBase(p) := newBase(p-1) + top(p-1) - Base(p-1) + Integer(Float'Floor(tau)) -  integer(Float'Floor(sigma));
         sigma := tau;
      end loop;
       -- ReA6
      Top(currentStackNumber) := Top(currentStackNumber) - 1;

      -- perform movestack
      move(Top, Base, numStacks);

      Top(currentStackNumber) := Top(currentStackNumber) + 1;
      -- insert overflow item into top[k]
      stackspace(Top(currentStackNumber)) := name;

      return true;
   end reallocate;


   procedure move( Top: in out intArray; Base: in out intArray; N: integer) is
      Delt: integer;
   begin
      for J in 2..N loop
         if newBase(J) < Base(J) then
            Delt := Base(J) - newBase(J);
            for L in (Base(J)+1)..Top(J) loop
               StackSpace(L - Delt) := StackSpace(L);
            end loop;
            Base(J) := newBase(J);
            Top(J) := Top(J) - Delt;
         end if;
      end loop;
      for J in reverse 2..N loop
         if newBase(J) > Base(J) then
            Delt := newBase(J) - Base(J);
            for L in reverse (Base(J)+1)..Top(J) loop
               StackSpace(L + Delt) := StackSpace(L);
            end loop;
            Base(J) := newBase(J);
            Top(J) := Top(J) + Delt;
         end if;
      end loop;
   end move;


   ------------------------
   -- Push onto Stack
   ------------------------
   function push( currentStackNumber: in integer; name: in Unbounded_String) return boolean is
   begin
      -- increment up one before starting
      top(currentStackNumber) := top(currentStackNumber) + 1;

      -- if full, return false and overflow
      if top(currentStackNumber) > base(currentStackNumber+1) then
         put_line("stack overflow at stack " & Integer'Image(currentStackNumber));
         new_line;
         return false;
      else
         put("Inserting " & To_String(name)& " into stack number " & Integer'Image(currentStackNumber) & " at stack location" & Integer'Image(top(currentStackNumber)) );
         New_Line;
         stackspace(top(currentStackNumber)) := name;
         return true;
      end if;
   end push;

   ------------------------
   -- Pop From Stack
   ------------------------
   procedure pop(currentStackNumber: in integer) is
   begin
      if top(currentStackNumber) = base(currentStackNumber) then
         put_line("stack underflow" & Integer'Image(currentStackNumber));
      else
         put("popping from stack number" & Integer'Image(currentStackNumber) & " " & To_String(stackspace(top(currentStackNumber))));
         New_Line;
         stackspace(top(currentStackNumber)) := to_unbounded_string(" ");
         top(currentStackNumber) := top(currentStackNumber) - 1;
      end if;
   end pop;


end genericStack;
