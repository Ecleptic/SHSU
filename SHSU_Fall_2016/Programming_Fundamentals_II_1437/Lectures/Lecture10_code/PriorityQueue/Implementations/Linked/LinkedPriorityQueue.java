/** 
   A class of priority queues represented by a chain of linked nodes.
   
   @author Frank M. Carrano
   @author Timothy M. Henry
   @author Charles Hoot
   @version 4.0
*/
public final class LinkedPriorityQueue<T extends Comparable<? super T>>
                                         implements PriorityQueueInterface<T>
{
   private Node firstNode; // Reference to first node of chain and the front
                           // of the priority queue, which has the highest priority
   private int  length;    // Number of entries in chain

   public LinkedPriorityQueue()
   {
      firstNode = null;
      length = 0;
   } // end default constructor

   public void add(T newEntry)
   {
      Node newNode = new Node(newEntry);
      Node nodeBefore = getNodeBefore(newEntry);

      if (isEmpty() || (nodeBefore == null)) // Add at beginning
      {
         newNode.setNextNode(firstNode);
         firstNode = newNode;
      }
      else                                   // Add after nodeBefore
      {
         Node nodeAfter = nodeBefore.getNextNode();
         newNode.setNextNode(nodeAfter);
         nodeBefore.setNextNode(newNode);
      } // end if

      length++;
   } // end add

   public T remove()
   {
      return remove(1);  // 1-based, so this is the front
   } // end remove

   public T peek()
   {
     return getEntry(1); // 1-based, so this is the front
   } // end getFront

   public boolean isEmpty()
   {
      boolean result;
            
      if (length == 0)
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

   public int getSize()
   {
      return length;
   }

   public void clear()
   {
      firstNode = null;
      length = 0;
   } // end clear

   public void display()
   {
      Node currentNode = firstNode;
      while (currentNode != null)
      { 
         System.out.println(currentNode.getData());
         currentNode = currentNode.getNextNode(); 
      } // end while  
   } // end display

   // Returns either a reference to the node that is before the node 
   // that contains or should contain anEntry, or null if
   // no prior node exists (that is, if anEntry belongs at
   // the beginning of the chain) 
   private Node getNodeBefore(T anEntry)
   {
     Node currentNode = firstNode;
     Node nodeBefore = null;
     
     while ( (currentNode != null) && 
             (anEntry.compareTo(currentNode.getData()) >= 0) ) // Use >= instead of >
     {
        nodeBefore = currentNode;
        currentNode = currentNode.getNextNode();
     } // end while
     
     return nodeBefore;
   } // end getNodeBefore

   private Node getNodeAt(int givenPosition)
   {
      assert !isEmpty() && (1 <= givenPosition) && (givenPosition <= length);
      Node currentNode = firstNode;

      // Traverse the chain to locate the desired node
      for (int counter = 1; counter < givenPosition; counter++)
         currentNode = currentNode.getNextNode();

      assert currentNode != null;
      return currentNode;
   } // end getNodeAt

   private T getEntry(int givenPosition)
   {
      T result = null;  // Result to return
      
      if ((givenPosition >= 1) && (givenPosition <= length))
      {
         assert !isEmpty();
         result = getNodeAt(givenPosition).getData();
      } // end if
          
      return result;
   } // end getEntry

   private T remove(int givenPosition)
   {
      T result = null;                           // Return value

      if ((givenPosition >= 1) && (givenPosition <= length))
      {
         assert !isEmpty();

         if (givenPosition == 1)                 // Case 1: remove first entry
         {
            result = firstNode.getData();        // Save entry to be removed
            firstNode = firstNode.getNextNode();
         }
         else                                    // Case 2: givenPosition > 1
         {
            Node nodeBefore = getNodeAt(givenPosition - 1);
            Node nodeToRemove = nodeBefore.getNextNode();
            Node nodeAfter = nodeToRemove.getNextNode();
            nodeBefore.setNextNode(nodeAfter);   // Disconnect the node to be removed
            result = nodeToRemove.getData();     // Save entry to be removed
         } // end if

         length--;
        } // end if
          
        return result;
   } // end remove
  
   private class Node
   {
      private T    data; // Entry in priority queue
      private Node next; // Link to next node

      private Node(T dataPortion) 
      {
         data = dataPortion;
         next = null;	
      } // end constructor
      
      private Node(T dataPortion, Node nextNode) 
      {
         data = dataPortion;
         next = nextNode;	
      } // end constructor
      
      private T getData()
      {
         return data;
      } // end getData
      
      private void setData(T newData)
      {
         data = newData;
      } // end setData
      
      private Node getNextNode()
      {
         return next;
      } // end getNextNode
      
      private void setNextNode(Node nextNode)
      {
         next = nextNode;
      } // end setNextNode
   } // end Node
} // end LinkedPriorityQueue