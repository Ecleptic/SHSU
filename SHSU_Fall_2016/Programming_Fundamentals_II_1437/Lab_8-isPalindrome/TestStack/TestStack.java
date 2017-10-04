public class TestStack
{
	public static void main(String[] args)
	{
		StackArrayBased aStack = new StackArrayBased();
	   	for (int i = 0; i < 10; i++) {
			aStack.push(new Integer(i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			aStack.pop();
		}
		System.out.println(aStack.toString());


		StackReferenceBased rStack = new StackReferenceBased();
	   	for (int i = 0; i < 10; i++) {
			rStack.push(new String("a"+i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			rStack.pop();
		}
		System.out.println(rStack.toString());

		StackListBased lStack = new StackListBased();
	   	for (int i = 0; i < 10; i++) {
			lStack.push(new Double(i));
		}  // end for
		for (int i = 0; i < 5; i++) {
			lStack.pop();
		}
		System.out.println(lStack.toString());

	}  // end main

}  // end StackTest
