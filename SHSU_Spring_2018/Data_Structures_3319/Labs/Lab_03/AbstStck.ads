--In file AbstStck.ads, Creation of abstract stack.
package AbstStck is
   type AbstractStack is limited private;

   type AbstractStackElement is tagged private;
   type AbstractStackElementPtr is
        access all AbstractStackElement'Class;
        --Allows access to AbstractStackElement and any class inheriting
        --(created fromusing inheritance) from AbstractStackElement.

   procedure Push(Stack: access AbstractStack; Y: in AbstractStackElementPtr);
   function   Pop(Stack: access AbstractStack) return AbstractStackElementPtr;
   function  StackSize(Stack: AbstractStack) return integer;
    --function “=” (aNode: AbstractStackElementPtr, valueToCompare: genreric-parameter-for-comparison) return Bollean;

    private
   type AbstractStackElement is tagged          -- Allow for heterogeneous
      record                                              --stacks via inheritance.
         Next: AbstractStackElementPtr;
      end record;
   type AbstractStack is limited
      record
         Count: integer := 0;                            --used to track the number of items in stack.
         Top: AbstractStackElementPtr := null;
      end record;
end AbstStck;
