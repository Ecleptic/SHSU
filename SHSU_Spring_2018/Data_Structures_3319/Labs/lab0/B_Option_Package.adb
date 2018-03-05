with Ada.Text_IO; use Ada.Text_IO;

package body B_Option_Package is

   function floor(x: float) return integer is
      temp: integer;
   begin
      temp := integer(x);
      if (float(temp) <= x) then
         return temp;
      else
         return temp - 1;
      end if;
   end floor;

   function reallocate(StackSpace: in out arrayType; Info: in out intArray; Base: in out intArray; Top: in out intArray; L: integer; M: integer; N: integer; K: integer; input: NameType) return boolean is

      AvailSpace: integer;
      TotalInc: integer := 0;
      MinSpace: integer := floor(0.05*(float(M) - float(L)));
      J: integer := N;
      Alpha: float;
      Beta: float;
      Sigma: float;
      Tau: float;
      temp: integer;
   begin
      if MinSpace = 0 then
         MinSpace := 1;
      end if;
      AvailSpace := M - L;
      while J > 0 loop
         AvailSpace := AvailSpace - (Top(J) - Base(J));
         if Top(J) > Info(J) then
            Info(J) := Top(J) - Info(J);
            TotalInc := TotalInc + Info(J);
         else
            Info(J) := 0;
         end if;
         J := J - 1;
      end loop;
      if AvailSpace < (MinSpace - 1) then
         put("OUT OF MEMORY, terminating program...");
         return false;
      end if;
      Alpha := 0.15 * float(AvailSpace) / float(N);
      Beta := 0.85 * float(AvailSpace) / float(TotalInc);
      Sigma := 0.0;
      temp := Info(1);
      Info(1) := Base(1);
      for J in 2..N loop
         Tau := Sigma + Alpha + float(temp)*Beta;
         temp := Info(J);
         Info(J) := Info(J-1) + Top(J-1) - Base(J-1) + floor(Tau) - floor(Sigma);
         Sigma := Tau;
      end loop;
      Top(K) := Top(K) - 1;
      movestack(StackSpace, Info, Top, Base, N);
      Top(K) := Top(K) + 1;
      StackSpace(Top(K)) := input;
      for J in 1..N loop
         Info(J) := Top(J);
      end loop;
      return true;
   end reallocate;

   procedure movestack(StackSpace: in out arrayType; Info: intArray; Top: in out intArray;
   	Base: in out intArray; N: integer) is

      Delt: integer;
   begin
      for J in 2..N loop
         if Info(J) < Base(J) then
            Delt := Base(J) - Info(J);
            for L in (Base(J)+1)..Top(J) loop
               StackSpace(L - Delt) := StackSpace(L);
            end loop;
            Base(J) := Info(J);
            Top(J) := Top(J) - Delt;
         end if;
      end loop;
      for J in reverse 2..N loop
         if Info(J) > Base(J) then
            Delt := Info(J) - Base(J);
            for L in Top(J)..(Base(J)+1) loop
               StackSpace(L + Delt) := StackSpace(L);
            end loop;
            Base(J) := Info(J);
            Top(J) := Top(J) + Delt;
         end if;
      end loop;
   end movestack;

end B_Option_Package;