--In file AbstStck.adb
package body AbstStck is
   procedure Push(Stack: access AbstractStack; Y: in AbstractStackElementPtr) is
      Pt: AbstractStackElementPtr;
   begin
      Y.Next := Stack.Top;
      Stack.Top := Y;
      Stack.Count := Stack.Count + 1;
   end Push;
   function Pop(Stack: access AbstractStack) return AbstractStackElementPtr is
      Pt: AbstractStackElementPtr;
   begin
      if Stack.Top = null
        then      --Check for underflow.
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