public class TestQueue
{
	public static void main(String[] args)
	{
		QueueArrayBased aQueue = new QueueArrayBased();
	   	for (int i = 0; i < 10; i++) {
			aQueue.enqueue(new Integer(i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			aQueue.dequeue();
		}
/*
		while (!aQueue.isEmpty()) {
      		System.out.print(aQueue.peek()+ " ");
      		Object item = aQueue.dequeue();
    	} // end while
    	System.out.println();
*/
		System.out.println(aQueue.toString());


		QueueReferenceBased rQueue = new QueueReferenceBased();
	   	for (int i = 0; i < 10; i++) {
			rQueue.enqueue(new String("a"+i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			rQueue.dequeue();
		}


/*
 		while (!rQueue.isEmpty()) {
      		System.out.print(rQueue.dequeue()+ " ");
      		Object item = rQueue.dequeue();
    	} // end while
    	System.out.println();
*/
		System.out.println(rQueue.toString());

		QueueListBased lQueue = new QueueListBased();
	   	for (int i = 0; i < 10; i++) {
			lQueue.enqueue(new Double(i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			lQueue.dequeue();
		}
/*
		while (!lQueue.isEmpty()) {
      		System.out.print(lQueue.peek()+ " ");
      		Object item = lQueue.dequeue();
    	} // end while
    	System.out.println();
*/
		System.out.println(lQueue.toString());

	}  // end main

}  // end QueueTest
