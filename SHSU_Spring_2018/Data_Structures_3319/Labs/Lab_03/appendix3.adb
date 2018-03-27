generic -- in file CompStkg.ads
type MyType is private;
package CompStkg is
    procedure Push(X: MyType);
    function Pop return MyType; -- Note parenthesis are not required if there are no parameters.

    private

    type Node; -- Avoid recursive definition.
    type NodePtr is access Node; -- Define pointer type to Node.

    type Node is record -- Allocated in heap at run time.
        MyData: MyType;
        Next: NodePtr;
    end record;
end CompStkg;

with Ada.Unchecked_Deallocation; -- in file CompStkg.adb
package body CompStkg is
    -- Provide opportunity for garbage collection and reuse of Nodes.
    function free is new Ada.Unchecked_Deallocation(Node, NodePtr); -- reclaim heap storage.
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
        free(pt); -- Memory hemorraging occurs if forgotten. return X;
    end Pop;

end CompStkg;


-- Example of programming by "Composition" (bottom-up, creating whole from parts)
-- as opposed to programming by "Classification"
-- (top-down) better known as the use of inheritance.
with Ada.Text_IO; use Ada.Text_IO;
with CompStk1; use CompStk1;
with CompStkg;
procedure UCmpStkg is -- in file UCmpStkg
package CharStack is new CompStkg(character);
use CharStack;
package DateStack is new CompStkg(CompStk1.Date);
use DateStack;

Char: Character; ADate: Date;

begin

Push('A');
Push('B');
Push('C');
put(pop);
put(Pop);
put(Pop);
new_line(2);
Push((Jan, 15, 1992));
Push((Mar, 24, 1994));
Push((Jun, 12, 1999));
ADate := Pop; PrintDate(ADate);
new_line;
Adate := Pop;
    PrintDate(Adate);
    new_line;
    Adate := Pop;
    PrintDate(ADate);
    new_line;
end;