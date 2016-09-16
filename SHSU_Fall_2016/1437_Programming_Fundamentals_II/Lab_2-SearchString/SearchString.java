import java.io.*;
import java.util.*;
import java.lang.Integer;
import java.util.concurrent.TimeUnit;



public class SearchString
{
/*
        Initialize all my variables. I'll probably get rid of quite a few of them, but until I am complete I will keep them.
 */
public static final String textFile = "sortedStrings.txt";
public static final String TO_STOP = "-1";
public static final int NOT_FOUND = -1;

public static int count;
public static int count1;
public static int count2;
public static int count3;

public static String[] wordArray;
private static String word;

public synchronized static void readFile() throws IOException {
/*
        readFile() is going to take the sortedStrings.txt(textFile) and using the while loop we're going to put it in a
        List<string>. But I don't like lists. I'm much much more comfortable with parsing and editing arrays so I'm going to put the string list into the string array. It doubles the computation of readFile() but I believe it will be much better for the later searches.
 */
        // create textString
        String textString = "";
        // create Scanner stringFile to read the file
        Scanner stringFile = new Scanner(new File(textFile));
        // create tempList which we will put stringFile into
        List<String> tempList = new ArrayList<String>();
        // while loop to put stringFile inside tempList
        while (stringFile.hasNext()) {
                // find next line
                textString = stringFile.nextLine();
                tempList.add(textString);
        }
        stringFile.close();
        // converts and saves tempList to the array wordArray
        wordArray = tempList.toArray(new String[tempList.size()]);
}

public static int sequentialNameSearch(String wordSearch) throws IOException {
        /*
                so I need to decide if I'm going to make these functions ints or strings. That's what is going to get returned. so I need to figure out what I'm returning. Can I just return that string? It'll make my main function much cleaner. Or I can make them void since most everything is public (yes I realize it's bad code.)
         */
        // take whatever is in wordSearch and make it lowercase(just in case);
        String lowerWordSearch =  wordSearch.toLowerCase();
        System.out.println("lowerWordSearch: "+lowerWordSearch);
        // def sequentialSearch(alist, item):
        count1 = 0;
        int index = 0;
        boolean found = false;
        while(!found && index < wordArray.length) {
                if (wordArray[index].equals(lowerWordSearch)) {
                        System.out.println("true: "+lowerWordSearch);
                        found = true;
                        word = lowerWordSearch;
                        System.out.println("Word found: " + word +" Count: " + index);
                }else {
                        index++;
                }
        }
        // for sequentialNameSearch I can just make count1 equal to index + 1.  I can't usually do that.
        count1 = index + 1;
        if (!found) {
                word = '"'+wordSearch+'"'+" not found (comparison = "+count1+")";
        } else{
                word = '"'+wordSearch+'"'+ " is found in ["+index+"] (comparison = "+count1+")";
        }
        return index;
}


public static void main(String[] args) throws IOException, InterruptedException {
        /*

         */
        readFile();
        if (wordArray==null) {
                readFile();
        }
        sequentialNameSearch("computer");
        System.out.println(word);
        System.out.println(count1);

        // System.out.println("pray for me");
}    // end of main()

}
