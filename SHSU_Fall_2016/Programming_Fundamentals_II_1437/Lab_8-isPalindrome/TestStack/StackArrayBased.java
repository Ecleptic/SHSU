import ListReferenceBased.*;

public class StackArrayBased implements StackInterface {

	final int MAX_STACK = 50;
	private Object items[];
	private int top, numItems; //index for stack top

	public StackArrayBased(){
		items = new Object[MAX_STACK];
		top = -1;
		numItems = 0;
	}

	public boolean isEmpty(){
		return (top <0);
	}

	public boolean isFull(){
		return (top == MAX_STACK-1);
	}

	public void push(Object newItem) throws QueueException{
		if(!isFull()){ items[++top] = newItem; numItems++;}
		else{
			throw new QueueException("StackException on push: Stack full");
		}
	}

	public Object pop() throws QueueException{
		if(!isEmpty()){
			numItems--;
			return items[top--];
		}
		else {
			throw new QueueException("StackException on pop: Stack empty");
		}
	}

	public void popAll(){
		items = new Object[MAX_STACK];
		top = -1;
		numItems--;
	}

	public Object peek() throws QueueException{
		if(!isEmpty()) return items[top];
		else{
			throw new QueueException("StackException on peek: Stack Empty");
		}
	}

	public String toString()
	{

	 StringBuilder s = new StringBuilder();
	 for(int i = 0; i < numItems; i++){
		 s.append(items[top+i]+" ");
	 }
	 return s.toString();
    } // end of toString

}