import ListReferenceBased.*;

public class StackListBased implements StackInterface{
	private ListInterface list;

	public StackListBased(){
		list = new ListReferenceBased();
	}

	public boolean isEmpty(){
		return list.isEmpty();
	}

	public void push(Object newItem){
		list.add(0, newItem);
	}

	public Object pop() throws QueueException{
		if(!list.isEmpty()){
			Object temp = list.get(0);
			list.remove(0);
			return temp;
		} else {
			throw new QueueException("StackException on pop: Stack Empty");
		}
	}

	public void popAll(){
		list.removeAll();
	}

	public Object peek() throws QueueException{
		if(!isEmpty()) return list.get(0);
		else {
			throw new QueueException("StackException on peek: Stack empty");
		}
	}

   @Override
   public String toString()
   {
 	StringBuilder s = new StringBuilder();
 	for(int i = 0; i < list.size(); i++){
		s.append(list.get(i)+" ");
	}
	return s.toString();

   } // end of toString

}