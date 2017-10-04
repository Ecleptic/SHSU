/**
   This class has a recursive method, message,
   which displays a message n times.
*/

public class Recursive
{
   public static void message(int n)
   {
      if (n > 0)
      {
         message(n -1);
         System.out.println("This is a recursive method. "+ n);
      }
   }
}