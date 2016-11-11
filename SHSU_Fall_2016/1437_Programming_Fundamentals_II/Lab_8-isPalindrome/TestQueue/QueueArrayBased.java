public class QueueArrayBased implements QueueInterface
{
  private final int MAX_QUEUE = 50; // maximum size of queue
  private Object[] items;
  private int front, back, count;

  public QueueArrayBased()
  {
    items = null;
    front = 0;
    back = 0;
    count = 0;
  }  // end default constructor

  // queue operations:
  public boolean isEmpty()
  {
    return true;
  }  // end isEmpty

  public boolean isFull()
  {
    return true;
  }  // end isFull

  public void enqueue(Object newItem) throws QueueException
  {
    if (!isFull()) {
      back = back+1;
      items[back] = newItem;
      ++count;
    } else {
      throw new QueueException("QueueException on enqueue: Queue full");
    }  // end if
  }  // end enqueue

  public Object dequeue() throws QueueException
  {
    if (!isEmpty()) {
      // queue is not empty; remove front
      Object queueFront = items[front];
      front = front+1;
      --count;
      return queueFront;
    } else {
      throw new QueueException("QueueException on dequeue: Queue empty");
    }   // end if
  }  // end dequeue

  public void dequeueAll()
  {
    items = null;
    front = 0;
    back = 0;
    count = 0;
  }  // end dequeueAll

  public Object peek() throws QueueException
  {
    if (!isEmpty()) {
      // queue is not empty; retrieve front
      return items[0];
    } else {
      throw new QueueException("Queue exception on peek: Queue empty");
    }  // end if
  }  // end peek


  public String toString()
  {
	  return null;
  } // end of toString


} // end QueueArrayBased
