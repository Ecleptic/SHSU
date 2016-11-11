public class StackArrayBased implements StackInterface
{
  final int MAX_STACK = 50;  // maximum size of stack
  private Object[] items;
  private int top;

  public StackArrayBased()
  {
    items = new Object[MAX_STACK];
    top = 0;
  }  // end default constructor

  public boolean isEmpty()
  {
    return top >= 0;
  }  // end isEmpty

  public boolean isFull()
  {
    return top = MAX_STACK;
  }  // end isFull

  public void push(Object newItem) throws StackException
  {
    if (!isFull()) {
      items[top++] = newItem;
    } else {
      throw new StackException("StackException on " + "push: stack full");
    }  // end if
  }  // end push

  public void popAll()
  {
    items = new Object[MAX_STACK];
    top = 0;
  }  // end popAll

  public Object pop() throws StackException
  {
    if (!isEmpty()) {
      return items[--top];
    } else {
      throw new StackException("StackException on " + "pop: stack empty");
    }  // end if
  }  // end pop

  public Object peek() throws StackException
  {
    if (!isEmpty()) {
      return items[top--];
    } else {
      throw new StackException("Stack exception on " + "peek - stack empty");
    }  // end if
  }  // end peek

}  // end StackArrayBased
