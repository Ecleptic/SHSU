package  warshall is
   type matrix is array(Positive range <>, Positive range <>) of boolean;
   procedure warshallFunc(bMatrix: in out matrix);
end warshall;