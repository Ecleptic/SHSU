import java.io.*;
import java.util.*;
import java.lang.Integer;
import java.util.concurrent.TimeUnit;



public class SearchString
{
public static final String TO_STOP = "-1";
public static final int NOT_FOUND = -1;
public static final int MAX_SIZE = 1000;

public static int count;
public static int count1;
public static int count2;
public static int count3;

public static String[] wordArray;
private static String word;

public synchronized static void readFile() throws IOException {
        // create textString
        String textString = "";
        // create Scanner stringFile
        Scanner stringFile = new Scanner(new File("sortedStrings.txt"));
        List<String> temp = new ArrayList<String>();
        // while loop
        while (stringFile.hasNext()) {
                // find next line
                textString = stringFile.nextLine();
                temp.add(textString);
        }
        stringFile.close();
        wordArray = temp.toArray(new String[temp.size()]);
}

public static String sequentialNameSearch() throws IOException {
        System.out.println("We're in sequentialNameSearch");
        System.out.println(wordArray);  //Seems to return null
        System.out.println("Word 12: ");
        System.out.print(wordArray[12]);
        System.out.println("Word 12234: ");
        System.out.println(wordArray[12234]);

        word = wordArray[count];
        System.out.println("word: "+ word);
        return word;
}


public static void main(String[] args) throws IOException, InterruptedException {
        readFile();
        if (wordArray==null) {
                readFile();
        }
        sequentialNameSearch();

        // System.out.println("pray for me");

        //do something else
        // }



        // sequentialNameSearch(15);

}    // end of main()

}
