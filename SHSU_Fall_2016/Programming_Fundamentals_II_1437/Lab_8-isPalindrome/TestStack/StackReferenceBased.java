import ListReferenceBased.*;

public class StackReferenceBased implements StackInterface{

	private Node top;
	private int numItems = 0;

	public StackReferenceBased(){
		top = null;
		numItems = 0;
	}

	public boolean isEmpty(){
		return (top == null);
	}

	public void push(Object newItem){
		top = new Node(newItem, top);
		numItems++;
	}

	public Object pop() throws QueueException{
		if(!isEmpty()){
			Node temp = top;
			top = top.getNext();
			numItems--;
			return temp.getItem();
		} else {
			throw new QueueException("StackException on pop: Stack empty");
	}
}

	public void popAll(){
		top = null;
		numItems = 0;
	}

	public Object peek() throws QueueException{
		if(!isEmpty()) return top.getItem();
		else{
			throw new QueueException("StackException on peek: Stack empty");
		}
	}

   public String toString()
   {
	  StringBuilder s = new StringBuilder();
	  for(int i = 0; i < numItems; i++){
	  	s.append(top.getItem()+" ");
	  	this.pop();
	  	numItems++;
	  }

	   return s.toString();
   } // end of toString

}