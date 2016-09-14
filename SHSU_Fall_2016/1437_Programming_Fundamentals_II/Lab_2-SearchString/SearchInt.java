import java.io.*;
import java.util.Scanner;
import java.lang.Integer;


public class SearchInt
{
  public static final String TO_STOP = "-1";
  public static final int NOT_FOUND = -1;
  public static final int MAX_SIZE = 1000;

  public static int count1;
  public static int count2;
  public static int count3;


  public int sequentialSearch(int[] array, int value)
  {
	int low = 0;
	int high = array.length - 1;
	for (int i = low; i <= high; i++){
		count1++;
		if (array[i] == value)
			return i;
	}
	return NOT_FOUND;
  } // end of sequentialSearch()

  public int sequentialSearch1( int[] list, int item)
  {
    int location = -1;
    for (int i = 0; i < list.length; i++){
      if (list[i] == item)
        location = i;
      }
      return location;
  }

  public int sequentialSearch2( int[] list, int item)
  {
    int location = -1;
    boolean found = false;
    for (int i = 0; i < list.length && !found; i++){
      if (list[i] == item)
      {
        location = i;
        found = true;
      }
    }
    return location;
  }

  public int sequentialSearch3( int[] list, int item)
  {
	  int index = 0;
	  boolean found = false;
	  while (!found && index < list.length){
		  if (list[index] == item)
		  	found = true;
		  else
		  	index++;
	  }
	  return index;
   }


  public int binarySearch(int[] array, int value)
  {
	int low = 0;
	int high = array.length - 1;
	while (low <= high) {
		int mid = (low + high)/2;
		count2++;
		if (array[mid] > value){
			high = mid - 1;
		} else if (array[mid] < value){
			low = mid + 1;
	   	} else
			return mid;
	}
	return NOT_FOUND;
  } // end of binarySearch()


  public int binarySearch(int[] array, int low, int high, int value)
  {
	if (low > high)
		return NOT_FOUND;
	int mid = (low + high)/2;
	count3++;
	if (array[mid] > value){
		return binarySearch(array, low, mid-1, value);
	} else if (array[mid] < value){
		return binarySearch(array, mid+1, high, value);
	} else
		return mid;
  } // end of binarySearch()



  public static void main(String[] args) throws IOException
  {

	int[] array = new int[MAX_SIZE];

    for (int i = 0; i < MAX_SIZE; i++)
    	array[i] = i;

	Scanner keyboard = new Scanner(System.in);

    boolean wantToContinue = true;

	SearchInt si = new SearchInt();

    do {
		System.out.print("Type a positive int to search ("+ TO_STOP + " to stop): ");
		String word2Search = keyboard.nextLine();
		if (word2Search.equals(TO_STOP)){
			wantToContinue = false;
		} else {
			int int2Search = Integer.parseInt(word2Search);
			count1 = count2 = count3 = 0;
			int index;

			index = si.sequentialSearch(array, int2Search);
			if (index == NOT_FOUND)
				System.out.println("sequentialSearch()      : " + int2Search + " is not found (comparison=" + count1 + ").");
			else
				System.out.println("sequentialSearch()      : " + int2Search + " is found in [" + index + "] (comparison=" + count1 + ").");

			index = si.binarySearch(array, int2Search);
			if (index == NOT_FOUND)
				System.out.println("iterative binarySearch(): " + int2Search + " is not found (comparison=" + count2 + ").");
			else
				System.out.println("iterative binarySearch(): " + int2Search + " is found in [" + index + "] (comparison=" + count2 + ").");

			index = si.binarySearch(array, 0, array.length-1, int2Search);
			if (index == NOT_FOUND)
				System.out.println("recursive binarySearch(): " + int2Search + " is not found (comparison=" + count3 + ").");
			else
				System.out.println("recursive binarySearch(): " + int2Search + " is found in [" + index + "] (comparison=" + count3 + ").");
		}
	} while (wantToContinue);
  } // end of main()

} // end of TestSearch