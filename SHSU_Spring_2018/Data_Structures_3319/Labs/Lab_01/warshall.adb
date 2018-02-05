package body warshall is
   procedure warshallFunc(char: in out inChars )  is
   begin
      for I in 1..char'length
       loop
         for j in 1..char'length
            loop
            if char(J,I) = true then
               for k in 1..char'length
                    loop
                  char(J,K) := char(J,K) or char(I,K);
               end loop;
            end if;
         end loop;
      end loop;
   end warshallFunc;
end warshall;