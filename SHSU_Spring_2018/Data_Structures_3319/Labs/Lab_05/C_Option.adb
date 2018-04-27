-----------------------------------------------------------
-- Lab 05 Program
-- C-Option
-- Cameron Green
-----------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;
with BST_Template; use BST_Template;
with Unchecked_Conversion;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;



procedure C_Option is

    treeKnt : integer := 0;
    Root :  binarySearchTreePoint;
    tmp :   binarySearchTreePoint;
    node :  binarySearchTreePoint;
    name, number : String10;

begin

    InsertBinarySearchTree(Root,    ("Nkwantal  "), ("295-1492  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Idle      "), ("291-1864  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Green     "), ("295-1601  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Realzola  "), ("293-6122  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Easlon    "), ("295-1882  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Bolen     "), ("291-7890  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Hedreen   "), ("294-8075  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Bell      "), ("584-3622  "));
    treeKnt := treeKnt + 1;


    FindCustomerIterative(Root, ("Bolen     "),tmp);
    put_line(string(customerPhone(tmp)));
    FindCustomerRecursive(Root, ("Bolen     "),tmp);
    put_line(string(customerPhone(tmp)));

    FindCustomerIterative(Root, ("Penton    "),tmp);
    put_line(string(customerPhone(tmp)));
    FindCustomerRecursive(Root, ("Penton    "),tmp);
    put_line(string(customerPhone(tmp)));


    FindCustomerRecursive(Root, ("Easlon    "),tmp);
    for i in 1..2 loop
        node := InOrderSuccessor(tmp);
        put_line(string(customerName(tmp)));
        tmp := node;
    end loop;


    new_line;
    put_line("Adding more");
    new_line;

    InsertBinarySearchTree(Root,    ("Altayyar  "), ("294-1568  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Gammons   "), ("294-1882  "));
    treeKnt := treeKnt + 1;
    InsertBinarySearchTree(Root,    ("Whitehead "), ("295-6622  "));
    treeKnt := treeKnt + 1;

tmp := root;
 for i in 1..treeKnt loop
        node := InOrderSuccessor(tmp);
        put_line(string(customerName(tmp)));
        tmp := node;
    end loop;

exception
   when constraint_error =>
      Put_line (" ");

end C_Option;