package body warshall is
   procedure warshallFunc(bMatrix: in out inChars )  is
   begin
      for I in 1..bMatrix'length
       loop
         for j in 1..bMatrix'length
            loop
            if bMatrix(J,I) = true then
               for k in 1..bMatrix'length
                    loop
                  bMatrix(J,K) := bMatrix(J,K) or bMatrix(I,K);
               end loop;
            end if;
         end loop;
      end loop;
   end warshallFunc;
end warshall;