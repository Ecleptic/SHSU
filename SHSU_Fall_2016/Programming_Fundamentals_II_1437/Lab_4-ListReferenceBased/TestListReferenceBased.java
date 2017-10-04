// ********************************************************
// Test Reference-based implementation of the ADT list.
// *********************************************************
public class TestListReferenceBased {



static public void main(String[] args)
{
								ListReferenceBased aList = new ListReferenceBased();

								aList.add(0, new Integer(1));
								aList.add(1, new Integer(2));
								aList.add(2, new Integer(3));
								aList.add(3, new Integer(4));
								aList.add(4, new Integer(5));
								aList.add(5, new Integer(6));

								System.out.println("===========================");
								for (int i = 0; i < aList.size(); i++)
																System.out.println(aList.get(i));

								System.out.println("Size with size() = " + aList.size());
								System.out.println("Size with getSize() = " + aList.getSize());
								System.out.println("Size with getSizeRecursive() = " + aList.getSizeRecursive());

/*
   System.out.println("Initial List = " + aList);
   aList.reverse();	// iterative version
   System.out.println("Reverse with reverse() = " + aList);

   System.out.println("====================================");

   aList.reverseRecursive();	// recursive version
   System.out.println("Reverse with reverseRecursive() = " + aList);
 */
								int offset = 3;
								Node node = aList.findMToLast(offset);
								if (node != null)
																System.out.println(offset + "-th node to the last node contains " + node.getItem());
								else
																System.out.println("Offset(=" + offset + ") to the last node is greater than list size(=" + aList.size() + ").");

}  // end main

}  // end TestListReferenceBased
