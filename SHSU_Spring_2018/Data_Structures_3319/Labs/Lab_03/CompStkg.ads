with Ada.Unchecked_Deallocation; -- in file CompStkg.adb
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