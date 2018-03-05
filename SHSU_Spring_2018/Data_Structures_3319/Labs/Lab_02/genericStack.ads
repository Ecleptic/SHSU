with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package genericStack is

   type names is (zhou, wei, burris, shashidhar, deering, an, lester, yang, smith, arcos, rabieh, song, cho, varol, karabiyik, cooper, mcguire, najar, hope, pray, nohope);
   type namesArray is array(Integer range <>) of Unbounded_String;
   type intArray is array(Integer range <>) of integer;

   function reallocate(stackspace: in out namesArray; growth: in out intArray;oldTop: in out intArray; newBase: in out intArray; Base: in out intArray; Top: in out intArray; l0: integer; M: integer; N: integer; K: integer; input: Unbounded_String) return boolean;
   procedure move(stackspace: in out namesArray; growth: intArray; Top: in out intArray; base: in out intArray; n: integer);
   -- at the begin, set the top and bottom to 0 and setup everything... so i only need to use the funcitions.
   function push(stackspace: in out namesArray; top: in out intArray; base: in out intArray; stackNum: in integer; name: in Unbounded_String) return boolean;
   procedure pop(stackspace: in out namesArray; top: in out intArray; base: in out intArray; stackNum: in integer);

end genericStack;
