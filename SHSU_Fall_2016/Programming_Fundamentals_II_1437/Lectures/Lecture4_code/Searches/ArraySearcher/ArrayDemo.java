import java.util.Arrays;

public class ArrayDemo {

   public static void main(String[] args) {

   // intializing an array arr1
   int[] arr1 = new int[] {45, 32, 75};

   // printing the array
   System.out.println("Printing 1st array:");
   for (int i = 0; i < arr1.length; i++)
   {
   System.out.println(arr1[i]);  
   }

   // copying array arr1 to arr2 with newlength as 5
   int[] arr2 = Arrays.copyOf(arr1, 5);
   //arr2[3] = 11;
   //arr2[4] = 55;   

   // printing the array arr2
   System.out.println("Printing new array:");
   for (int i = 0; i < arr2.length; i++) 
   {
   System.out.println(arr2[i]);
   }
   }
}