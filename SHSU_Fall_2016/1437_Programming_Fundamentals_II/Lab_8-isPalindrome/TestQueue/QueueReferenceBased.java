import ListReferenceBased.*;

public class QueueReferenceBased implements QueueInterface
{
  private Node lastNode;
  private int numItems = 0;

  public QueueReferenceBased()
  {
    lastNode = null;
    numItems = 0;
  }  // end default constructor


  // queue operations:
  public boolean isEmpty() {
    return (numItems == 0);
  }  // end isEmpty

  public void dequeueAll()
  {
    lastNode = null;
    numItems = 0;
  }  // end dequeueAll

  public void enqueue(Object newItem)
  {
    Node newNode = new Node(newItem);

    // insert the new node
    if (isEmpty()) {
      // insertion into empty queue
      newNode.setNext(newNode);
    } else {
      // insertion into nonempty queue
      newNode.setNext(lastNode.getNext());
      lastNode.setNext(newNode);
    }  // end if
    numItems++;
    lastNode = newNode;  // new node is at back
  }  // end enqueue

  public Object dequeue() throws QueueException
  {
    if (!isEmpty()) {
      // queue is not empty; remove front
      Node firstNode = lastNode.getNext();
      if (firstNode == lastNode){ // special case?
        lastNode = null;          // yes, one node in queue
        numItems--;
      } else { //more than one item
        lastNode.setNext(firstNode.getNext());
   	    numItems--;
   	  }  // end if
      return firstNode.getItem();
    } else {
      throw new QueueException("QueueException on dequeue: Queue empty");
    }  // end if
  }  // end dequeue

  public Object peek() throws QueueException
  {
    if (!isEmpty()) {
      // queue is not empty; retrieve front
      Node firstNode = lastNode;
      return firstNode.getItem();
    } else {
      throw new QueueException("QueueException on peek: Queue empty");
    }  // end if
  }  // end peek


  public String toString(){
	/*
	*
     StringBuilder s = new StringBuilder();
	 for(int i = 0; i < numItems; i++){
		 s.append(items[front+i]+" ");
	 }
	 return s.toString();
	 *
	*
	*/

	StringBuilder s = new StringBuilder();
	for(int i = 0; i < numItems; i++){
		s.append(lastNode.getNext().getItem()+" ");
		this.dequeue();
		numItems++;
	}
	return s.toString();
  } // end of toString

} // end QueueReferenceBased
