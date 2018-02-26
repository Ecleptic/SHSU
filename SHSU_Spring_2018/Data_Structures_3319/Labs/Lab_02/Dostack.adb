-- in file Dostack.adb
with Ada.Text_IO;
use Ada.Text_IO;
procedure dostack is
package MyInt_IO is new Ada.Text_IO.Integer_IO(integer);
use MyInt_IO;

    m: integer;
	max: constant := 100; -- Declare the stack
	s: array(1..max) of integer;
	top: integer range 0..max := 0;

	procedure push(x: integer) is
	begin
		top := top + 1;
 s(top) := x;
	end push;

	procedure pop(x: out integer) is
	begin
		x := s(top);
  top := top - 1;
	end pop;

begin
top := 0; --initialize top of stack to empty
for i in 1..4 loop
	put("enter an integer");
 get(m);
 push(m);
end loop;

for i in 1..4 loop
	put("result of pop");
 pop(m);
 put(m);
 new_line;
end loop;
end dostack;
