public class Node
{
  private String item;
  private Node next;

  public Node(String newItem)
  {
    item = newItem;
    next = null;
  } // end constructor

  public Node(String newItem, Node nextNode)
  {
    item = newItem;
    next = nextNode;
  } // end constructor

  public void setItem(String newItem)
  {
    item = newItem;
  } // end setItem

  public String getItem()
  {
    return item;
  } // end getItem

  public void setNext(Node nextNode)
  {
    next = nextNode;
  } // end setNext

  public Node getNext()
  {
    return next;
  } // end getNext

} // end class Node
