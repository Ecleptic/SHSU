/**
   An abstract base class for use in implementing the ADT list
   by using a chain of nodes. All methods are implemented, but
   since the class is abstract, no instances can be created.
   
   @author Frank M. Carrano
   @author Timothy M. Henry
   @version 4.0
*/
public abstract class LinkedChainBase<T>
{
	private Node firstNode; // Reference to first node
	private int  numberOfEntries;

	public LinkedChainBase()
	{
		initializeDataFields();
	} // end default constructor

	public final void clear()
	{
		firstNode = null;
		numberOfEntries = 0;
	} // end clear
  
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
   
   // Initializes the class's data fields to indicate an empty list.
   private void initializeDataFields()
   {
		firstNode = null;
		numberOfEntries = 0;
   } // end initializeDataFields
	
	// Returns a reference to the node at a given position.
   // Precondition: List is not empty;
   //               1 <= givenPosition <= numberOfEntries	
	protected final Node getNodeAt(int givenPosition)
	{
		assert !isEmpty() && (1 <= givenPosition) && (givenPosition <= numberOfEntries);
		Node currentNode = firstNode;
		
      // Traverse the list to locate the desired node
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
       
      T result = firstNode.getData();     // save entry to be removed 
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

      return nodeToRemove.getData();  // Return removed entry
	} // end removeAfterNode

	protected final class Node
	{
		private T data;     // Entry in list
		private Node next;  // Link to next node

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
} // end LinkedChainBase



