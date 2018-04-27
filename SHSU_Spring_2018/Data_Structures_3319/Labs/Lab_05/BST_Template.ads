with gStack;

package BST_Template is

      type string10 is new String(1..10);	--may not need in end

      type BinarySearchTreePoint is limited private;


   procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint; custName: in string10; custPhone: string10 );
                                                   -- This procedure locates a customer using a binary search. A pointer is returned to the
                                                   -- customer record if they exist, otherwise a Null pointer is returned (in CustomerPoint).
                                                   -- The search must be implemented iteratively.

   procedure FindCustomerIterative(Root: in BinarySearchTreePoint; CustomerName: in string10; CustomerPoint: out BinarySearchTreePoint);
                                                   -- This procedure locates a customer using a binary search. A pointer is returned to the -- customer record if they exist, otherwise a Null pointer is returned (in CustomerPoint). -- The search must be implemented recursively.

   procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; CustomerName: in string10; CustomerPoint: out BinarySearchTreePoint);
                                                   -- This function returns the address of the next node in “inorder” taking advantage of threads.
                                                   -- The user may enter the tree at any random location. This is sometimes called an iteration
                                                   -- function or iterater (no recursion).
   function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) return BinarySearchTreePoint;

   procedure createRoot;
   procedure main;

   procedure allocateNode(T: out BinarySearchTreePoint; custname: in string10 ; custphone: in string10) ;
   procedure insertNode(P: BinarySearchTreePoint; T: BinarySearchTreePoint; custname: in string10; custphone: in string10);
   procedure pushRecord(Info: in string10);
   -- Access functions to return customer names and phone numbers.

      function CustomerName(TreePoint: in BinarySearchTreePoint) return String10;
      function CustomerPhone(TreePoint: in BinarySearchTreePoint) return String10;
   -- function getName(Info: in string10) return string10;

      private
      type Customer is
      record
            Name: String10;
            Number: String10;
      end record;
      type Node;
      type BinarySearchTreePoint is access Node;
      type Node is
      record
            Llink: BinarySearchTreePoint;
            Rlink: BinarySearchTreePoint;
            Ltag : Boolean;
            Rtag: Boolean; -- True indicates pointer to lower level, False a thread.
            Info: Customer;
      end record;

end BST_Template;