with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Unchecked_Deallocation;
package body CompStkg is
   -- Provide opportunity for garbage collection and reuse of Nodes.
   --function free is new Unchecked_Deallocation(Node, NodePtr); -- reclaim heap storage.
   procedure Free is new  Ada.Unchecked_Deallocation(Node, NodePtr);-- reclaim heap storage.

   Head, pt: NodePtr := null; -- Ada actually sets all pointers to null when they are declared.

   procedure Push(X: MyType) is
   begin -- No check for overflow.
      Head := new Node'(X, Head); -- Allocated from returned memory, heap is none returned.
   end Push; -- Most languages return Head = null if out of storage.

   function Pop return MyType is
      X: MyType;
   begin
      X := Head.MyData; -- No check for underflow.
      pt := Head;
      Head := Head.Next;
      free(pt); -- Memory hemorraging occurs if forgotten.
      return X;
   end Pop;

end CompStkg;