import java.util.Scanner;import TreePackage.DecisionTreeInterface;import TreePackage.DecisionTree;/**   A driver for the class GuessingGame as given in Listing 23-5.    @author Frank M. Carrano   @author Timothy M. Henry   @version 4.0*/public class Client{   	public static void main(String[] args)	{		GuessingGame game = new GuessingGame("Is it in North America?", "Brazil", "U.S.A.");      String response;      do      {         System.out.println("Think of a country and I will guess it. ");         game.play();         System.out.print("Play again? ");         response = getUserResponse();      } while (response.toLowerCase().equals("yes"));      System.out.println("Bye!");	}  // end main      public static String getUserResponse()   {      Scanner keyboard = new Scanner(System.in);      String response = keyboard.nextLine();            return response;   } // endgetUserResponse      public static boolean isUserResponseYes()   {      String answer = getUserResponse();      if (answer.toLowerCase().equals("yes"))         return true;      else         return false;   } // end isUserResponseYes} // end Client/* Think of a country and I will guess it. Is it in North America? yes My guess is U.S.A.. Am I right? no I give up; what are you thinking of? Canada Give me a question whose answer is yes for Canada but no for U.S.A. Is it north of Montana? Play again? yes Think of a country and I will guess it. Is it in North America? yes Is it north of Montana? yes My guess is Canada. Am I right? yes I win. Play again? no Bye!*/