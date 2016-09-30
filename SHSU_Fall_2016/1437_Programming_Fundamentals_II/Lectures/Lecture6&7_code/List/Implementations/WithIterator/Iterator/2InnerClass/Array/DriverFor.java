import java.util.List;
/** 
   A driver that demonstrates the for-each statement with a class, 
   such as ArrayListWithIterator, that implements Iterable. Note
   that ArrayListWithIterator implements Iterable because
   ListWithIteratorInterface extends Iterable.
  
   @author Frank M. Carrano
   @author Timothy M. Henry
   @version 4.0
*/
public class DriverFor
{
  public static void main(String[] args) 
  {
		ListWithIteratorInterface<Integer> integerList = new ArrayListWithIterator<>();
		integerList.add(16); 
		integerList.add(4);  
		integerList.add(33); 
		integerList.add(27); 

		for (Integer entry : integerList)
		  System.out.print(entry + " ");
		System.out.println();	

		ListWithIteratorInterface<String> nameList = new ArrayListWithIterator<>();
		nameList.add("Joe"); 
		nameList.add("Jess");  
		nameList.add("Josh"); 
		nameList.add("Joy"); 

		for (String name : nameList)
		   System.out.print(name + " ");
		System.out.println();	
  } // end main
} // end DriverFor

/*
16 4 33 27 
Joe Jess Josh Joy 

*/