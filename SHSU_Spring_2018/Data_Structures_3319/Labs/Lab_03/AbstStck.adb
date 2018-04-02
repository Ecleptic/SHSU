--In file AbstStck.adb
with Ada.Text_IO; use Ada.Text_io;

package body AbstStck is
   procedure PushBot(Stack: access AbstractStack; Y: in AbstractStackElementPtr) is
      --Pt: AbstractStackElementPtr;
   begin
      if Stack.Count = 0
      then
         -- put_line("New stack!");
         Y.Next := Stack.Top;
         Stack.Top := Y;
         Y.Prev := Stack.Bottom;
         Stack.Bottom := Y;
         Stack.Count := Stack.Count + 1;
      else
         Y.Next := Stack.Bottom;
         Stack.Bottom.Prev := Y;
         Stack.Bottom := Y;
         Stack.Count := Stack.Count + 1;
      end if;
      -- put_line("PUSHING BOT! :D");
   end PushBot;
   procedure PushTop(Stack: access AbstractStack; Y: in AbstractStackElementPtr) is
     -- Pt: AbstractStackElementPtr;
   begin
      if Stack.Count = 0
      then
         -- put_line("New stack!");
         Y.Next := Stack.Top;
         Stack.Top := Y;
         Y.Prev := Stack.Bottom;
         Stack.Bottom := Y;
         Stack.Count := Stack.Count + 1;
      else
         Y.Prev := Stack.Top;
         Stack.Top.Next := Y;
         Stack.Top := Y;
         Stack.Count := Stack.Count + 1;
      end if;
      -- put_line("PUSHING Top! :D");
   end PushTop;

   function Pop(Stack: access AbstractStack) return AbstractStackElementPtr is
      Pt: AbstractStackElementPtr;
   begin
      if Stack.Top = null
        then		--Check for underflow.
         put("Null Stack");
         return null;
      end if;
      Stack.Count := Stack.Count - 1;
      Pt := Stack.Top;
      Stack.Top := Stack.Top.Prev;  -- Pop stack, note hemmoraging.
      return Pt;						        -- Storage should be returned to an available storage list for applications
   end Pop;								          -- with high activity or executing for extended periods of time.



   function StackSize(Stack: AbstractStack) return integer is
   begin
      return Stack.Count;
   end StackSize;
end AbstStck;