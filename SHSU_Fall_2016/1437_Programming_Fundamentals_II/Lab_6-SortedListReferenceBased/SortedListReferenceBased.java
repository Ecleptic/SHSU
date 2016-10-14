// ********************************************************
// Reference-based implementation of the ADT Sorted List.
// *********************************************************
 /**
 * class SortedListReferenceBased
 *
 *    A class that implements the SortedListInterface using a linked list
 *
 */

public class SortedListReferenceBased extends ListReferenceBased
{

  	public SortedListReferenceBased()
  	// creates an empty list
  	{
		// YOUR CODE WILL BE HERE...

  	}  // end default constructor


  	public void add(String item) throws ListException
  	// Inserts item into its proper position in a sorted list
  	// Throws an exception if the item connot be placed on the list
  	{
		try
		{
			// YOUR CODE WILL BE HERE...
			// DEFINE ANY HELPER METHOD(S) AND CALL IT/THEM, IF YOU NEED ANY.
		}
		catch(Exception e)
		{
			throw new ListException("Add to List failed:  " + e.toString());
		}

	}


  	public void remove(String item) throws ListException
  	// Removes the item from a sorted list.
  	// Throws an exception if the item is not found.
  	{
		try
		{
			// YOUR CODE WILL BE HERE...
			// REQUIREMENT: USE "locateIndex(String item)" method.
		}
		catch(Exception e)
		{
			throw new ListException("Remove " + item.toString() + " from List failed:  " + e.toString());
		}
	}

  	public int locateIndexToAdd(String item)
  	// Returns the position where the item belongs or exists in a sorted list;
  	// item and the list are unchanged.
  	{
		// YOUR CODE WILL BE HERE...
		return 0;
	}

  	public int locateIndexToRemove(String item)
  	// Returns the position where the item belongs or exists in a sorted list;
  	// item and the list are unchanged.
  	{
		// YOUR CODE WILL BE HERE...
		return 0;
	}

}  // end SortedListReferenceBased


