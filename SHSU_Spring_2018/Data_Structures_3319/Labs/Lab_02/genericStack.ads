with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;



package genericStack is

   type names is (zhou, wei, burris, shashidhar, deering, an, lester, yang, smith, arcos, rabieh, song, cho, varol, karabiyik, cooper, mcguire, najar, hope, pray, nohope);
   type namesArray is array(Integer range <>) of Unbounded_String;
   type intArray is array(Integer range <>) of integer;

   numStacks : integer := 4;
   totalMemory: integer := 27;
   upper : integer := 24;
   lower: integer := 4;
   l0: integer := 4;
   top : intArray (1..numStacks);
   base : intArray (1..numStacks+1);

   stackspace: array (-11..60) of Unbounded_String;
   -- top: array (1..numStacks) of integer;
   oldTop: array (1..numStacks) of integer;
   -- base: array (1..numStacks) of integer;
   oldBase: array (1..numStacks) of integer;



   function reallocate(stackspace: in out namesArray; growth: in out intArray;oldTop: in out intArray; newBase: in out intArray; Base: in out intArray; Top: in out intArray; l0: integer; M: integer; N: integer; K: integer; input: Unbounded_String) return boolean;
   procedure move(stackspace: in out namesArray; growth: intArray; Top: in out intArray; base: in out intArray; n: integer);
   -- at the begin, set the top and bottom to 0 and setup everything... so i only need to use the funcitions.
   function push(stackNum: in integer; name: in Unbounded_String) return boolean;
   procedure pop(stackNum: in integer);

end genericStack;
