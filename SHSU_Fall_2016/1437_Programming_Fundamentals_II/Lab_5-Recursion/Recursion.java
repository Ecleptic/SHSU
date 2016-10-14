//=========
//RECURSION
//=========

//In this lab, we practice some of well-known algorithms
//in recursive or/and non-recursive (i.e., iterative) version(s).

//------
//TASKS:
//------
//
//(1) Implement all the required methods in a java class,
//    called "RecursionAnswer.java".
//    ==> Let's add "public" access modifier to every method.
//    ==> Implement every to be a class method.
//    ==> Correct any possible errors (Hint: change method's signature).
//
//(2) Implement main() for all the methods.
//    ==> public static void main(String []args)
//    ==> Test what each method returns.

//----------------
// Running Example
//----------------
//Test fact(int n):
//	fact1(10) = 3628800
//	fact2(10) = 3628800
//Test WriteBackward(String str, int size):
//	writeBackword1("Your name", 9) = eman ruoY
//	writeBackword2("Your name", 9) = eman ruoY
//	writeBackword3("Your name", 9) = eman ruoY
//	writeBackword4("Your name", 9) = eman ruoY
//Test sum(int n):
//	sum1(10) = 55
//	sum2(10) = 55
//Test rangeSum(int array, int m, int e)
//	rangeSum1(array, m, e) = 49
//	rangeSum2(array, m, e) = 49
//Test fib(int n):
//	fib1(1) = 1
//	fib2(1) = 1
//	fib3(1) = 1
//	fib1(2) = 1
//	fib2(2) = 1
//	fib3(2) = 1
//	fib1(10) = 55
//	fib2(10) = 55
//	fib3(10) = 55
//Test acker(int m, int n):
//	acker(0, 10) = 11
//	acker(3, 0) = 5
//	acker(3, 10) = 8189
//Test gcd(m, n):
//	gcd(3, 10) = 1
//Test c(n, m):
//	c(10, 3) = 120



import java.util.Scanner;


public class Recursion {



	// -----------------------------------------------------
	// Computes the factorial of a nonnegative integer.
	// Precondition:
	//		n must be greater than or equal to 0.
	// Postcondition:
	//		Returns the factorial of n.
	//
	// n! = 1			if n == 0
	// n! = n * (n-1)!	if n > 0
	// -----------------------------------------------------


	public static int fact(int n)
	{
		if (n == 0)
			// 1 line (?)

		else
			// 1 line (?)

	}


	public static int fact(int n)
	{
		int result = 1;
		if (n == 0)
			// do nothing (i.e. result = 1)
		else
			for (int i = 2; i <= n; i++)
				result *= i;
		return result;
	}





	// --------------------------------------------------------
	// Writes a character string backward.
	// Precondition:
	//		The string s contains size characters, where size >= 1.
	// Postcondition:
	//		s is written backward, but remains unchanged.
	// --------------------------------------------------------


	public static void writeBackward(String s, int size)
	{  // base case
		if(size == 1)
			System.out.print(s.charAt(0));
		// else, write rest of string
		else if (size > 1)
		{
			System.out.print(s.charAt(size-1));
			writeBackward(s, size - 1);
		}
	   // else size <= 0, do nothing;
	} // end writeBackward


	public static void writeBackward(String s, int size)
	{
		if (size > 0){
			System.out.println(s.substring(size-1, size));
			writeBackward(s, size - 1);
		}
	}


	public static void writeBackward(String s, int size)
	{
		while (size > 0){
			System.out.println(s.substring(size-1, size));
			--size;
		}
	}


	public static void writeBackward(String s)
	{
		for (int i = s.length()-1; i>= 0; i--)
			System.out.print(s.charAt(i));
		System.out.println();
	}



public static void writeBackward(String s, int size)
	{
		for (int i = size-1; i>= 0; i--)
			System.out.print(s.charAt(i));
		System.out.println();
	}




	//------------------------------------------------------
	// Evaluate the sum of the first n integers
	//
	// sum = 1				if n == 1
	// sum = n + sum(n-1)	if n > 1;
	//------------------------------------------------------


	public static int sum(int n)
	{
		if (n == 1)
			// 1 line (?)

		else
			// 1 lin3 (?)
	}


	public static int sum(int n)
	{
		int result = 0;
		for (i = 1; i <= n; i++)
			result += i;
		return result;
	}





	//---------------------------------------------------
	// Evaluate the sum of the integers in a given range
	//	(i.e., from start to end)
	//---------------------------------------------------


	public static int rangeSum(int [] array, int start, int end)
	{
		if (start > end)
			return 0;
		else
			return array[start] + rangeSum(array, start + 1, end);
	}


	public static int rangeSum(int [] array, int start, int end)
	{
		int sum = 0;
		for (int i = start; i <= end; i++)
			sum += array[i];
		return sum;
	}





	//---------------------------------------------------
	// fib(n) = 0						if n == 0
	// fib(n) = 1						if n == 1
	// fib(n) = fib(n-1) + fib(n-2)		if >= 2
	//---------------------------------------------------


	public static int fib(int n)
	{
		if (n == 0)
			// 1 line (?)

		else if (n == 1)
			// 1 line (?)

		else
			// 1 line (?)

	}


	public static int fib(int n)
	{
		int previous = 1;
		int current = 1;
		int next = 2;
		if (n == 1 || n == 2)
			next = 1;

		for (int i = 3; i <= n; i++){
			// 3 lines (?)



		}
		return next;
	}


	public static int fib(int n)
	{
		int[] array = new int[n+1];
		array[0] = 1;
		array[1] = 1;
		for (int i = 2; i <= n; i++)
			// 1 line(?)


		// 1 line(?) return(???)
	}



	//-------------------------------------------------------
	// acker(m, n) = n + 1						if m == 0
	// acker(m, n) = acker(m - 1, 1)				if n == 0
	// acker(m, n) = acker(m - 1, acker(m, n - 1))	otherwise
	//-------------------------------------------------------


	int acker(int m, int n)
	{
		if (m == 0)
			// 1 line (?)

		else if (n == 0)
			// 1 line (?)

		else
			// 1 line (?)

	}





	//---------------------------------------------------
	// gcd(a, b) = b				if (a mod b) == 0
	// gcd(a, b) = gcd(b, a mod b)	otherwise
	//---------------------------------------------------


	public static int gcd(int a, int b)
	{
		if (a % b == 0)
			// 1 line (?)

		else
			// 1 line (?)

	}





	//----------------------------------------------------
	// Computes the number of groups of k out of n things.
	// Precondition:
	//		n and k are nonnegative integers.
	// Postcondition:
	//		Returns c(n, k)
	//
	// c(n, k) = 1	if k == 0
	// c(n, k) = 1	if k == n
	// c(n, k) = 0	if k > n
	// c(n, k) = c(n - 1, k - 1) + c(n - 1, k)	if 0 < k < n
	//----------------------------------------------------


	public static static int c(int n, int k)
	{
		if ((k == 0) || (k == n)
			// 1 line (?)

		else if (k > n)
			// 1 line (?)

		else
			// 1 line (?)
	}




	public static void main(String [] args)
	{
		String str = new String("Your name");
		int[] array = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		int m = 3;
		int n = array.length;
		int e = array.length - 1;


		System.out.println("Test fact(int n):");
		System.out.println("\tfact1(" + n + ") = " + fact1(n));
		System.out.println("\tfact2(" + n + ") = " + fact2(n));

		// Add your codes for the remaining methods


	} // end of main()


} // end of Recusion