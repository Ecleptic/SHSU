/**
   A class that implements the ADT list by using a chain of nodes.
   
   @author Frank M. Carrano
   @author Charles Hoot
   @author Timothy M. Henry
   @version 4.0
*/
public class LinkedChainList<T> extends LinkedChainBase<T>
                             implements ListInterface<T>
{
	public LinkedChainList()
	{
		super(); // Initializes the linked chain
	} // end default constructor

	public void add(T newEntry)                    // OutOfMemoryError possible
	{
		Node newNode = new Node(newEntry);
		
		if (isEmpty())
			addFirstNode(newNode);
		else                                        // Add to end of non-empty list
		{
			Node lastNode = getNodeAt(getLength());  // Get last node
			addAfterNode(lastNode, newNode);	        // Make last node reference new node
		} // end if
	}  // end add
   
   public void add(int newPosition, T newEntry)   // OutOfMemoryError possible
	{
		if ((newPosition >= 1) && (newPosition <= getLength() + 1))
		{
			Node newNode = new Node(newEntry);       // Create new node
         
			if (newPosition == 1)                    // Case 1
				addFirstNode(newNode);
			else									           // Case 2: list is not empty
			{                                        // and newPosition > 1
				Node nodeBefore = getNodeAt(newPosition - 1);
				addAfterNode(nodeBefore, newNode);
			} // end if
		}
		else
         throw new IndexOutOfBoundsException("Illegal position given to add operation.");
	} // end add

	public T remove(int givenPosition)
	{
      T result = null;                           // Return value
      
      if ((givenPosition >= 1) && (givenPosition <= getLength()))
      {
         assert !isEmpty();
         
         if (givenPosition == 1)                 // Case 1: Remove first entry
            result = removeFirstNode();
         else                                    // Case 2: Not first entry
         {
            Node nodeBefore = getNodeAt(givenPosition - 1);
            result = removeAfterNode(nodeBefore);// Save entry to be removed
         } // end if
         
         return result;                          // Return removed entry
      }
      else
         throw new IndexOutOfBoundsException("Illegal position given to remove operation.");
	} // end remove

	public T replace(int givenPosition, T newEntry)
	{
      if ((givenPosition >= 1) && (givenPosition <= getLength()))
      {
      	assert !isEmpty();
         
			Node desiredNode = getNodeAt(givenPosition);
         T originalEntry = desiredNode.getData();
			desiredNode.setData(newEntry);
         return originalEntry;
      }
		else
         throw new IndexOutOfBoundsException("Illegal position given to replace operation.");
   } // end replace
   
   public T getEntry(int givenPosition)
   {
		if ((givenPosition >= 1) && (givenPosition <= getLength()))
		{
			assert !isEmpty();
         return getNodeAt(givenPosition).getData();
     	}
      else
         throw new IndexOutOfBoundsException("Illegal position given to getEntry operation.");
   } // end getEntry

	public boolean contains(T anEntry)
	{
		boolean found = false;
		Node currentNode = getFirstNode();
		
		while (!found && (currentNode != null))
		{
			if (anEntry.equals(currentNode.getData()))
				found = true;
			else
				currentNode = currentNode.getNextNode();
		} // end while
		
		return found;
	} // end contains
} // end LinkedChainList



