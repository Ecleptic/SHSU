/**
   This class has a recursive method, message,
   which displays a message n times.
*/

public class Recursive2
{
   public static void displayArray(int array[], int first, int last)
   {
      if (first <= last)
      {
         System.out.println(array[last] + " ");
         displayArray(array, first, last-1);
         
      }
   }
}