generic -- in file Gstack.ads
max:integer; -- size of stack
type item is private; -- type to stack
package gstack is
procedure push(x: in item);
procedure pop(x: out item);
end gstack;

package body gstack is -- in file Gstack.adb
s:array(1..max) of item; -- allocate in stack.
top: integer range 0..max;

procedure push(x: in item) is
begin
top := top + 1; s(top) := x;
end push;
procedure pop(x: out item ) is
result of pop 20 result of pop 10

begin
x := s(top); top := top - 1;
end pop;
begin
top := 0; --initialize top of stack to empty
end gstack;

with Ada.Text_IO; use Ada.Text_IO; -- in file Gusestac.adb
with gstack; -- generic stack defined in gstack10.ads /.adb
procedure genstack is
package IIO is new Ada.Text_IO.Integer_IO(integer); use IIO;
package integer_stack is new gstack(100,integer); use integer_stack;
m: integer;
begin
for i in 1..4 loop
put("enter an integer "); end loop;
get(m);
push(m);
for i in 1..4 loop
put("result of pop "); pop(m); put(m); new_line;
end loop;
end genstack;
-- Consider adding: package intStk is new gstack(10,integer); use intStk;
-- Now push(m) will result in a compile time error as “Push” cannot be

--uniquely determined from the context. Use intStk.push(m) or
--integer_stack.push(m), the full object oriented notation.


-- Now consider using the “date” type. A skeleton follows.
with Ada.Text_IO; use Ada.Text_IO; with gstack;;
with CompStkg; use CompStkg;
procedure UCmpStkg is -- in file UCmpStkg stackSize: integer := 15;
package DateStack is new gstack(stackSize, Date);
use DateStack;
-- rest followed by access, shown 2 ways
push(aDate); --if stack is clearly identifiable (unique0 or to specify using
DateStack.push( aDate ); -- DateStac if there are multiple date stacks.

