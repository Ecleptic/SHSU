type Link;
type Link_Access is access Link;
type Link is record
  Next : Link_Access := null;
  Prev : Link_Access := null;
  Data : Integer;
end record;

--Using generics, the specification might look like this:


generic
   type Element_Type is private;
package Linked_List is
   type List_Type is limited private;
-- ...
private
   type List_Element;
   type List_Element_Ptr is access list_element;
   type List_Element is
      record
	 Prev : List_Element_Ptr;
	 Data : Element_Type;
	 Next : List_Element_Ptr;
      end record;
   type List_Type is
      record
	 Head        : List_Element_Ptr;     -- Pointer to first element.
	 Tail        : List_Element_Ptr;     -- Pointer to last element.
	 Cursor      : List_Element_Ptr;     -- Pointer to cursor element.
	 Count       : Natural := 0;         -- Number of items in list.
	 Traversing  : Boolean := False;     -- True when in a traversal.
      end record;
end Linked_List;

-- In Ada 2005 this example can be written without declaration of an access type:

type Link is limited record
   Next : not null access Link := Link'Unchecked_Access;
   Prev : not null access Link := Link'Unchecked_Access;
   Data : Integer;
end record;

-- Here the list element is created already pointing to itself, so that no further initialization is required. The type of the element is marked as limited indicating that such elements have referential semantics and cannot be copied.


-- Ada's standard container library includes a generic doubly linked list. The structure of the link element is private.

