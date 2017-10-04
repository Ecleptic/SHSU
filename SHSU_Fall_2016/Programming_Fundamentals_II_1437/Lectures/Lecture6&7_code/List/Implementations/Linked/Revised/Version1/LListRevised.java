/**
   A class that implements the ADT list by using a chain of nodes
   and protected methods. (See Chpater 17.)
   
   @author Frank M. Carrano
   @author Timothy M. Henry
   @author Charles Hoot
   @version 4.0
*/
public class LListRevised<T>  
             implements ListInterface<T>
{
	private Node firstNode;                       // Reference to first node of chain
	private int  numberOfEntries;

	public LListRevised()
	{
		initializeDataFields();
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
		boolean isSuccessful = true;

		if ((newPosition >= 1) && (newPosition <= numberOfEntries + 1))
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
      
      if ((givenPosition >= 1) && (givenPosition <= numberOfEntries))
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

	public final void clear()
	{
		initializeDataFields();
	} // end clear
   
	public T replace(int givenPosition, T newEntry)
	{
      if ((givenPosition >= 1) && (givenPosition <= numberOfEntries))
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
		if ((givenPosition >= 1) && (givenPosition <= numberOfEntries))
		{
			assert !isEmpty();
         return getNodeAt(givenPosition).getData();
     	}
      else
         throw new IndexOutOfBoundsException("Illegal position given to getEntry operation.");
   } // end getEntry

   public T[] toArray()
   {
      // The cast is safe because the new array contains null entries
      @SuppressWarnings("unchecked")
      T[] result = (T[])new Object[numberOfEntries];
      
      int index = 0;
      Node currentNode = firstNode;
      while ((index < numberOfEntries) && (currentNode != null))
      {
         result[index] = currentNode.getData();
         currentNode = currentNode.getNextNode();
         index++;
      } // end while
      
      return result;
   } // end toArray
   
	public boolean contains(T anEntry)
	{
		boolean found = false;
		Node currentNode = firstNode;
		
		while (!found && (currentNode != null))
		{
			if (anEntry.equals(currentNode.getData()))
				found = true;
			else
				currentNode = currentNode.getNextNode();
		} // end while
		
		return found;
	} // end contains
   
   public int getLength()
   {
      return numberOfEntries;
   } // end getLength
   
   public boolean isEmpty()
   {
      boolean result;
      
      if (numberOfEntries == 0) // Or getLength() == 0
      {
         assert firstNode == null;
         result = true;
      }
      else
      {
         assert firstNode != null;
         result = false;
      } // end if
      
      return result;
   } // end isEmpty
   
   // Initializes the class's data fields to indicate an empty list.
   private void initializeDataFields()
   {
		firstNode = null;
		numberOfEntries = 0;
   } // end initializeDataFields
	
   // Returns a reference to the node at a given position.
   // Precondition: List is not empty;
   //               1 <= givenPosition <= numberOfEntries.
	protected final Node getNodeAt(int givenPosition)
	{
		assert !isEmpty() && (1 <= givenPosition) && (givenPosition <= numberOfEntries);
		Node currentNode = firstNode;
		
      // Traverse the chain to locate the desired node (skipped
      // if givenPosition is 1)
		for (int counter = 1; counter < givenPosition; counter++)
			currentNode = currentNode.getNextNode();
		
		assert currentNode != null;
      
		return currentNode;
	} // end getNodeAt

	// Returns the first node in the chain.
	protected final Node getFirstNode()
	{
	   return firstNode;
	} // end getFirstNode
	
	// Adds a node to the beginning of a chain. 
	protected final void addFirstNode(Node newNode)
	{
		assert newNode != null : "null argument in addFirstNode";
		
		newNode.setNextNode(firstNode);							
		firstNode = newNode;
		numberOfEntries++;
	} // end addFirstNode

	// Adds a node to a chain after a given node.
	protected final void addAfterNode(Node nodeBefore, Node newNode)
	{
		assert (nodeBefore != null) && (newNode != null) : "null argument in addAfterNode";

		Node nodeAfter = nodeBefore.getNextNode();
		newNode.setNextNode(nodeAfter);
		nodeBefore.setNextNode(newNode);
		numberOfEntries++;
	} // end addAfterNode

	// Removes a chain's first node.
	protected final T removeFirstNode()
	{
      assert firstNode != null : "empty list in removeFirstNode";
       
      T result = firstNode.getData();     // Save entry to be removed
      firstNode = firstNode.getNextNode();
       
      numberOfEntries--;
	    
		return result;
	} // end removeFirstNode

	// Removes the node after a given one. 
	protected final T removeAfterNode(Node nodeBefore)
	{
      assert nodeBefore != null : "null argument in removeAfterNode";
      Node nodeToRemove = nodeBefore.getNextNode();

      assert nodeToRemove != null : "no node to remove in removeAfterNode";
      Node nodeAfter = nodeToRemove.getNextNode();		
      nodeBefore.setNextNode(nodeAfter);  // Disconnect the node to be removed
		
		numberOfEntries--;
		
		return nodeToRemove.getData();      // Return removed entry
	} // end removeAfterNode

	protected class Node
	{
      private T    data; // Entry in list
      private Node next; // Link to next node

		protected Node(T dataPortion)
		{
			data = dataPortion;
			next = null;	
		} // end constructor

		private Node(T dataPortion, Node nextNode) // PRIVATE!
		{
			data = dataPortion;
			next = nextNode;	
		} // end constructor

		protected T getData()
		{
			return data;
		} // end getData
		
		protected void setData(T newData)
		{
			data = newData;
		} // end setData
		
		protected Node getNextNode()
		{
			return next;
		} // end getNextNode
		
		private void setNextNode(Node nextNode) // PRIVATE!
		{
			next = nextNode;
		} // end setNextNode
	} // end Node
} // end LListRevised



