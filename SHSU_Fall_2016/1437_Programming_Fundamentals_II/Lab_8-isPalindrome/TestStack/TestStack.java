public class TestStack {

	public static final int MAX_ITEMS = 10;


	// TEST FOR ARRAYED-BASED STACK IMPLEMENTATION...
  	public static void testArrayBasedStack()
  	{
		StackArrayBased sab = new StackArrayBased();
		Integer items[] = new Integer[MAX_ITEMS];
		for (int i=0; i<MAX_ITEMS; i++) {
			items[i] = new Integer(i);
			if (!sab.isFull())
				sab.push(items[i]);
		} // end for
		while (!sab.isEmpty()) {
        // cast result of pop to Integer
        	System.out.print((Integer)(sab.pop()) + " ");
        }// end while
        System.out.println();
	}


	// TEST FOR REFERENCE-BASED STACK IMPLEMENTATION...
  	public static void testReferenceBasedStack()
  	{
    	StackReferenceBased srb = new StackReferenceBased();
    	for (int i = 0; i < MAX_ITEMS; i++)
			srb.push(new Integer(i*10));
		while (!srb.isEmpty())
			System.out.print((Integer)(srb.pop()) + " ");
		System.out.println();

	}


	// TEST FOR LIST-BASED STACK IMPLEMENTATION...
  	public static void testListBasedStack()
  	{
		StackListBased slb = new StackListBased();
		for (int i = 0; i < MAX_ITEMS; i++)
			slb.push(new Integer(i*100));
		while (!slb.isEmpty())
			System.out.print((Integer)(slb.pop()) + " ");
		System.out.println();
	}


	public static void main(String[] args)
	{
		testArrayBasedStack();

		testReferenceBasedStack();

		testListBasedStack();

	} // end of main()


} // end StackTest