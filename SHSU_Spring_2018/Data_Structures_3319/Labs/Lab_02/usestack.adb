with Ada.Text_IO; use Ada.Text_IO;  --in file usestack.adb
with stack; use stack;
procedure usestack is
package IIO is new Ada.Text_IO.Integer_IO(integer); use IIO;

m: integer;

begin
for i in 1..4 loop
	put("enter an integer");
    get(m);
	stack.push(m);
end loop;

for i in 1..4 loop
	put("result of pop");
	stack.pop(m);   put(m);    new_line;
end loop;
end usestack;
