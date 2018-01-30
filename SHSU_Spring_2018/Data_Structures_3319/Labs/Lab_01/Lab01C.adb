-----------------------------------------------------------
-- Hello World program
-- C-Option
-- Cameron Green

-- Start with enumerating the a..j
-- figure out warshaws
-- print it


-- for B create a library of warshaws (.ads)



--
-- #7 should be the first character because that's the enumeration
-----------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
procedure Lab01C is
   i1: String(1 .. 2);
   i2: String(1 .. 2);
   i3: String(1 .. 2);
   i4: String(1 .. 2);
   i5: String(1 .. 2);
   i6: String(1 .. 2);

   empty: String := "    ";


   procedure createGraph(i1,i2,i3,i4,i5,i6:in String)  is
   begin
      put_line("A    B    C    D    E    F    G    I    J    K    L");
      put_line("A    "&"hi"&"                                            ");
      put_line("B                                                  ");
      put_line("C                                                  ");
      put_line("D                                                  ");
      put_line("E                                                  ");
      put_line("F                                                  ");
      put_line("G                                                  ");
      put_line("H                                                  ");
      put_line("I                                                  ");
      put_line("J                                                  ");
      put_line("K                                                  ");
      put_line("L                                                  ");
      put_line("M                                                  ");

   end createGraph;

abbcddlak
begin
   get(i1);
   get(i2);
   get(i3);
   get(i4);
   get(i5);
   get(i6);
   new_line;

   if i1(1) = i2(1) then
      put_line("ok");
   end if;
   createGraph(i1,i2,i3,i4,i5,i6);

   put_line(""&i1(1));
   put_line(""&i1(2));
   new_line;
   put_line(""&i2(1));
   put_line(""&i2(2));
   new_line;
   put_line(""&i3(1));
   put_line(""&i3(2));
   new_line;
   put_line(""&i4(1));
   put_line(""&i4(2));
   new_line;
   put_line(""&i5(1));
   put_line(""&i5(2));
   new_line;
   put_line(""&i6(1));
   put_line(""&i6(2));
   new_line;

end Lab01C;