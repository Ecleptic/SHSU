package  warshall is
   type inChars is array(Positive range <>, Positive range <>) of character;
   procedure warshallFunc(char: in out inChars);
end warshall;