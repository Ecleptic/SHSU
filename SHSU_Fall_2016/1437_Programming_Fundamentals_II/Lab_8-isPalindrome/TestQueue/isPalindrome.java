import java.util.Scanner;

public class isPalindrome {

    public static void main(String[] args){
		Scanner scan  = new Scanner(System.in);
		System.out.println("Word to check: ");

		String userInput = scan.nextLine();
		userInput = userInput.toUpperCase();
		System.out.print(isPal(userInput)+" ");


	}

	public static boolean isPal(String str){
		QueueArrayBased aQueue = new QueueArrayBased();
		StackArrayBased aStack = new StackArrayBased();

		for (int i = 0; i < str.length(); i++){
			aQueue.enqueue(str.charAt(i));
			aStack.push(str.charAt(i));
		}

		//start to compare

		while(!aQueue.isEmpty()){
			if(aQueue.dequeue() != aStack.pop()){
				return false;
			}
		}

		//finished w/ empty queue (and empty stack)

		return true;
	}

}