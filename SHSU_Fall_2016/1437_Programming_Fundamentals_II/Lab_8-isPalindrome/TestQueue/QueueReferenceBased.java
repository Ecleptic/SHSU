public class QueueReferenceBased implements QueueInterface
{
  private Node lastNode;

  public QueueReferenceBased()
  {
    lastNode == null;
  }  // end default constructor

  // queue operations:
  public boolean isEmpty() {
    return true;
  }  // end isEmpty

  public void dequeueAll()
  {
    lastNode == null;
  }  // end dequeueAll

  public void enqueue(Object newItem)
  {
    Node newNode = new Node(newItem);

    // insert the new node
    if (isEmpty()) {
      // insertion into empty queue
      newNode.setNext(null);
    } else {
      // insertion into nonempty queue
      newNode.setNext(lastNode);
      lastNode.setNext(newNode);
    }  // end if

    lastNode = newNode;  // new node is at back
  }  // end enqueue

  public Object dequeue() throws QueueException
  {
    if (isEmpty()) {
      // queue is not empty; remove front
      Node firstNode = lastNode;
      if (firstNode == lastNode) { // special case?
        lastNode = null;           // yes, one node in queue
      } else {
        lastNode.setNext(firstNode);
      }  // end if
      return firstNode.getItem();

    } else {
      throw new QueueException("QueueException on dequeue: Queue empty");
    }  // end if
  }  // end dequeue

  public Object peek() throws QueueException
  {
    if (isEmpty()) {
      // queue is not empty; retrieve front
      Node firstNode = lastNode;
      return firstNode.getItem();
    } else {
      throw new QueueException("QueueException on peek: Queue empty");
    }  // end if
  }  // end peek


  public String toString()
  {
	  return null;
  } // end of toString

} // end QueueReferenceBased
