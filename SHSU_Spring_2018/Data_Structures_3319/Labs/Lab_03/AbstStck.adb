--In file AbstStck.adb
with Ada.Text_IO; use Ada.Text_io;

package body AbstStck is
   procedure Push(Stack: access AbstractStack; Y: in AbstractStackElementPtr) is
      Pt: AbstractStackElementPtr;
   begin
      Y.Next := Stack.Top;
      Stack.Top := Y;
      Stack.Count := Stack.Count + 1;
      if Stack.Bottom = null then
        Y.Prev := Stack.Bottom;
         Stack.Bottom := Y;
      end if;
      put_line("PUSHING TOP! :D");
   end Push;
   procedure PushBot(Stack: access AbstractStack; Y: in AbstractStackElementPtr) is
      Pt: AbstractStackElementPtr;
   begin
      -- Y.Next := Stack.Top;
      -- Stack.Top := Y;
      -- Stack.Count := Stack.Count + 1;
      Y.Prev := Stack.Bottom;
      Stack.Bottom := Y;
      Stack.Count := Stack.Count + 1;
      if stack.Top = null then
        Y.Next := Stack.Top;
        Stack.Bottom := Y;
      end if;
      put_line("PUSHING BOT! :D");
   end PushBot;

   function Pop(Stack: access AbstractStack) return AbstractStackElementPtr is
      Pt: AbstractStackElementPtr;
   begin
      if Stack.Top = null
        then      --Check for underflow.
         put("Null Stack");
         return null;
      end if;
      Stack.Count := Stack.Count -1;
      Pt := Stack.Top;
      Stack.Top := Stack.Top.Next;  --Pop stack, note hemmoraging.
      return Pt;                    --Storage should be returned to an available storage list for applications
   end Pop;                         --with high activity or executing for extended periods of time.



   function StackSize(Stack: AbstractStack) return integer is
   begin
      return Stack.Count;
   end StackSize;
end AbstStck;