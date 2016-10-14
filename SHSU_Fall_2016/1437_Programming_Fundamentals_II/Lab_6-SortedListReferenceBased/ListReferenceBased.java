// ********************************************************
// Reference-based implementation of the ADT Sorted List.
// *********************************************************
 /**
 * class SortedListReferenceBased
 *
 *    A class that implements the SortedListInterface using a linked list
 *
 */

public class ListReferenceBased implements ListInterface
{
	private Node head;
  	private int numItems;  // number of items in list


  	public ListReferenceBased()
  	// creates an empty list
  	{
		//YOUR CODE GOES HERE.

  	}  // end default constructor

  	public boolean isEmpty()
  	// Determines whether a list is empty
  	{
		//YOUR CODE GOES HERE.
		return true;
  	} // end isEmpty

  	public int size()
  	// Returns the number of items that are in a list
  	{
		//YOUR CODE GOES HERE.
  		return 0;
  	}  // end size

    private Node find(int index)
    {
    // --------------------------------------------------
    // Locates a specified node in a linked list.
    // Precondition: index is the number of the desired node.
    // Assumes that 1 <= index <= numItems+1
    // Postcondition: Returns a reference to the desired node.
    // --------------------------------------------------
    	Node curr = head;
    	for (int skip = 0; skip < index; skip++) {
			curr = curr.getNext();
		} // end for
		return curr;
	} // end find


  public Object get(int index)
                throws ListIndexOutOfBoundsException {
    if (index >= 0 && index < numItems) {
      // get reference to node, then data in node
      Node curr = find(index);
      Object dataItem = curr.getItem();
      return dataItem;
    }
    else {
      throw new ListIndexOutOfBoundsException(
                "List index out of bounds on get");
    } // end if
  } // end get

  public void add(int index, Object item)
                  throws ListIndexOutOfBoundsException {
    if (index >= 0 && index <= numItems) {
      if (index == 0) {
        // insert the new node containing item at
        // beginning of list
		//YOUR CODE GOES HERE.
      }
      else {
        Node prev = find(index-1);
        // insert the new node containing item after
        // the node that prev references
		//YOUR CODE GOES HERE.
      } // end if
      numItems++;
    }
    else {
      throw new ListIndexOutOfBoundsException(
                "List index out of bounds on add");
    } // end if
  }  // end add

  public void remove(int index)
                     throws ListIndexOutOfBoundsException {
    if (index >= 0 && index < numItems) {
      if (index == 0) {
        // delete the first node from the list
		//YOUR CODE GOES HERE.
      }
      else {
		//YOUR CODE GOES HERE.
      } // end if
      numItems--;
    } // end if
    else {
      throw new ListIndexOutOfBoundsException(
                "List index out of bounds on remove");
    } // end if
  }   // end remove

  public void removeAll() {
    // setting head to null causes list to be
    // unreachable and thus marked for garbage
    // collection
	//YOUR CODE GOES HERE.
  } // end removeAll


  public String toString()
  {
	//YOUR CODE GOES HERE.
	return null;
  }


}  // end SortedListReferenceBased


