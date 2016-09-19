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
                TODO:so I need to decide if I'm going to make these functions ints or strings. That's what is going to get returned. so I need to figure out what I'm returning. Can I just return that string? It'll make my main function much cleaner. Or I can make them void since most everything is public (yes I realize it's bad code.)
         */
        // take whatever is in wordSearch and make it lowercase(just in case);
        String lowerWordSearch =  wordSearch.toLowerCase();
        // System.out.println("lowerWordSearch: "+lowerWordSearch);
        count1 = 0;
        int index = 0;
        boolean found = false;
        while(!found && index < wordArray.length) {
                if (wordArray[index].equals(lowerWordSearch)) {
                        // System.out.println("true: "+lowerWordSearch);
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
public static int iterativeBinarySearch(String word) {
        /*

         */
        int first = 0;
        int last  = wordArray.length;
        count2 = 0;
        while (first < last) {
                int mid = (first + last) / 2;
                if (word.compareTo(wordArray[mid]) < 0) {
                        last = mid;
                        count2++;
                } else if (word.compareTo(wordArray[mid]) > 0) {
                        count2++;
                        first = mid + 1;
                } else {
                        System.out.println('"'+word+'"'+ " is found in ["+mid+"] (comparison = "+count2+")");
                        return mid;
                }
        }
        System.out.println('"'+word+'"'+" not found (comparison = "+count2+")");
        return -(first + 1);
}

public static int recursiveBinarySearch(String word,int low, int high){
        // low = 0;
        // int high = wordArray.length -1;
        count3++;
        int mid;
        if (high < low) {
                return -1;
        }
        mid = (low + high) / 2;

        System.out.println("mid: "+ wordArray[mid] +", word: "+word + ", compare: "+wordArray[mid].compareTo(word));
        System.out.println("count: "+ count3);
        if(wordArray[mid].compareTo(word) == 0){
                System.out.println("GOTCHA!");
                System.out.println("Count: " + count3);
                return mid;
        }
        else if (wordArray[mid].compareTo(word) > 0) {
                // System.out.println("if");
                return recursiveBinarySearch(word, low, mid-1);
        }
        else if (wordArray[mid].compareTo(word) < 0) {
                // System.out.println("elif");
                return recursiveBinarySearch(word,mid+1,high);
        }
        else{
                return mid;
        }
}

/*

   // initially called with low = 0, high = N-1
   BinarySearch(A[0..N-1], value, low, high) {
     // invariants: value > A[i] for all i < low
                    value < A[i] for all i > high
     if (high < low)
         return not_found // value would be inserted at index "low"
     mid = (low + high) / 2
     if (A[mid] > value)
         return BinarySearch(A, value, low, mid-1)
     else if (A[mid] < value)
         return BinarySearch(A, value, mid+1, high)
     else
         return mid
   }*/
public static void main(String[] args) throws IOException, InterruptedException {
        /*

         */
        readFile();
        if (wordArray==null) {
                readFile();
        }
        // sequentialNameSearch("computer");
        // System.out.println(word);
        // System.out.println(count1);

        // iterativeBinarySearch("science");
        recursiveBinarySearch("science",0,wordArray.length);

        // System.out.println("pray for me");
}    // end of main()

}
