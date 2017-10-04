/**
   This class demonstrates the Recursive.message method.
*/

public class RecursionDemo2
{
   public static void main(String[] args)
   
   {
    int[] array1 = new int[5];
    for (int i=0;i<=4 ;i++ ) {
    array1[i] = i+1;      
    } // end of for
    Recursive2.displayArray(array1, 0, 4);
    int x = -4&1;
    System.out.print(x);
   }
}
