 /**
 * class SortedListDriver
 *
 *    A driver class to execute methods from SortedList{Array-|Reference-Based.java,
 *    which creates a sorted list and performs methods such as adding, deleting,
 *    finding a value in a list, and returning the index number.
 *
 */



public class SortedListDriver
{

  public static void main(String [] args)
  {
	//SortedListArrayBased myGroceryList = new SortedListArrayBased();
	SortedListReferenceBased myGroceryList = new SortedListReferenceBased();

	myGroceryList.add("milk");
	myGroceryList.add("eggs");
	myGroceryList.add("butter");
	myGroceryList.add("pecans");
	myGroceryList.add("apples");
	myGroceryList.add("bread");
	myGroceryList.add("chicken");
	myGroceryList.add("black beans");
	myGroceryList.add("rice");
	myGroceryList.add("sausage");
	myGroceryList.add("flour");

	printList(myGroceryList); //print out original List
	System.out.print("numItems is now: " + myGroceryList.size() + "\n\n");

	adding(myGroceryList, "juice");
	removing(myGroceryList, "juice");
	adding(myGroceryList, "banana");
	removing(myGroceryList, "sausage");
	removing(myGroceryList, "cheese");
  }

//  public static void adding(SortedListArrayBased myList, String str)
//  public static void adding(SortedListReferenceBased myList, String str)
  public static void adding(ListReferenceBased myList, String str)
  {
    System.out.println("Adding " + str + " ...");
 	myList.add(str);  //add juice
	printList(myList);
	System.out.print("numItems is now: " + myList.size() + "\n\n");
  }

//  public static void removing(SortedListArrayBased myList, String str)
//  public static void removing(SortedListReferenceBased myList, String str)
  public static void removing(ListReferenceBased myList, String str)
  {
    System.out.println("Removing " + str + " ...");
 	myList.remove(str);
	printList(myList);
	System.out.print("numItems is now: " + myList.size() + "\n\n");
  }

//  public static void printList(SortedListArrayBased myList)
//  public static void printList(SortedListReferenceBased myList)
  public static void printList(ListReferenceBased myList)
  {
	//method prints a list, numbering the values,  e.g, "0.  milk" .... "4.  juice".... etc.
	for (int index = 0; index < myList.size(); index++)
	{
	  System.out.printf("%2d. %s\n",index, (String) myList.get(index));
    }
  }


  public static void main()
  {

//	SortedListArrayBased myGroceryList = new SortedListArrayBased();
	SortedListReferenceBased myGroceryList = new SortedListReferenceBased();

	myGroceryList.add("milk");
	myGroceryList.add("eggs");
	myGroceryList.add("butter");
	myGroceryList.add("pecans");
	myGroceryList.add("apples");
	myGroceryList.add("bread");
	myGroceryList.add("chicken");
	myGroceryList.add("black beans");
	myGroceryList.add("rice");
	myGroceryList.add("sausage");
	myGroceryList.add("flour");

//	printList(myGroceryList); //print out original List
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

    System.out.println("adding juice ...");
 	myGroceryList.add ("juice");  //add juice
    System.out.println("item 5 is: " + myGroceryList.get(5)); //get the content at index 5
//	printList(myGroceryList);
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

	System.out.println("removing juice...");
	myGroceryList.remove ("juice");
//	printList(myGroceryList);
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

    System.out.println("removing apples...");
	myGroceryList.remove ("apples");
//	printList(myGroceryList);
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

	System.out.println("removing sausage...");
	myGroceryList.remove ("sausage"); //remove item at position (i.e., index) 5
//	printList(myGroceryList);
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

	System.out.println("removing cheese...");
	myGroceryList.remove ("cheese"); //remove item at position (i.e., index) 5
//	printList(myGroceryList);
	printList((SortedListReferenceBased) myGroceryList);
	System.out.print("numItems is now: " + myGroceryList.size() + "\n");

	System.out.println("main(String[] args) is called...");
  }


}
