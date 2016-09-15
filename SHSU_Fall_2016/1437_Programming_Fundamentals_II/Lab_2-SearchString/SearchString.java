import java.io.*;
import java.util.*;
import java.lang.Integer;



public class SearchString
{
public static final String TO_STOP = "-1";
public static final int NOT_FOUND = -1;
public static final int MAX_SIZE = 1000;

public static String count1;
public static String count2;
public static String count3;


public static void main(String[] args) throws IOException {

        // create textString
        String textString = "";
        // create Scanner stringFile
        Scanner stringFile = new Scanner(new File("sortedStrings.txt"));


        List<String> temp = new ArrayList<String>();

        // while loop
        while (stringFile.hasNext()) {
                // find next line
                textString = stringFile.next();
                temp.add(textString);
        }
        stringFile.close();

        String[] wordArray = temp.toArray(new String[0]);

                System.out.println(wordArray[12]);
                System.out.println(wordArray[12234]);
}    // end of main()

}
