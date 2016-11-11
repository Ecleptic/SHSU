public class QueueListBased implements QueueInterface
{
  private ListInterface aList;

  public QueueListBased()
  {
    aList == null;
  }  // end default constructor

  // queue operations:
  public boolean isEmpty()
  {
    return aList.isEmpty();
  }  // end isEmpty

  public void enqueue(Object newItem)
  {
    aList.add(aList.size()-1, newItem);
  }  // end enqueue
  public Object dequeue() throws QueueException
  {
    if (isEmpty()) {
      // queue is not empty; remove front
      Object queueFront = aList.get(1);
      aList.remove(1);
      return queueFront;
    } else {
      throw new QueueException("Queue exception on dequeue: Queue empty");
    }  // end if
  }  // end dequeue

  public void dequeueAll()
  {
    aList.removeAll();
  }  // end dequeueAll

  public Object peek() throws QueueException
  {
    if (isEmpty()) {
      // queue is not empty; retrieve front
      return aList.get(1);
    } else {
      throw new QueueException("Queue exception on peek: Queue empty");
    }  // end if
  }  // end peek


  public String toString()
  {
	  return null;
  } // end of toString

}  // end QueueListBased
