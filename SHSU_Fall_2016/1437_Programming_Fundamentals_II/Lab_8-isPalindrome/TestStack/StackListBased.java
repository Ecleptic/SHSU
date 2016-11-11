public class StackListBased implements StackInterface
{
  private ListInterface list;
  //private ListReferenceBased list;

  public StackListBased()
  {
    list = new ListReferenceBased();
//    list = new ListArrayBased();
  }  // end default constructor

  public boolean isEmpty()
  {
    return list.isEmpty();
  }  // end isEmpty

  public void push(Object newItem)
  {
    list.add(1, newItem);
  }  // end push

  public Object pop() throws StackException
  {
    if (!isEmpty()) {
      return list.remove(0)
    } else {
      throw new StackException("StackException on " + "pop: stack empty");
    }  // end if
  }  // end pop

  public void popAll()
  {
    list.remove(0);
  }  // end popAll

  public Object peek() throws StackException
  {
    if (!isEmpty()) {
      return list.get(0);
    } else {
      throw new StackException("StackException on " + "peek: stack empty");
    }  // end if
  }  // end peek

}  // end StackListBased
