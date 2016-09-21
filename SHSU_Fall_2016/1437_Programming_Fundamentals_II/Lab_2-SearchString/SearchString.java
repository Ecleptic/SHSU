import java.io.*;
import java.util.*;
import java.lang.Integer;
import java.util.concurrent.TimeUnit;


public class SearchString
{
/*
        Initialize all my variables. I'll probably get rid of quite a few of them, but until I am complete I will keep them.
 */
public static String textFile;  //= "sortedStrings.txt";
public static final String TO_STOP = "-1";
public static final int NOT_FOUND = -1;

public static int count = 0;
public static int count1 = 0;
public static int count2 = 0;
public static int count3 = 0;

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
        try {
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

        } catch (IOException e) {

        }

}

public static int sequentialNameSearch(String wordSearch) throws IOException {
        /*
                TODO:so I need to decide if I'm going to make these functions ints or strings. That's what is going to get returned. so I need to figure out what I'm returning. Can I just return that string? It'll make my main function much cleaner. Or I can make them void since most everything is public (yes I realize it's bad code.)
         */
        // take whatever is in wordSearch and make it lowercase(just in case);
        String lowerWordSearch =  wordSearch.toLowerCase();
        count1 = 0;
        int index = 0;
        boolean found = false;
        while(!found && index < wordArray.length) {
                if (wordArray[index].equals(lowerWordSearch)) {
                        found = true;
                        word = lowerWordSearch;
                        // System.out.println("sequentialNameSearch()      " + '"'+wordSearch+'"' +" is found in ["+index+"] (comparison = "+(index+1)+")");
                }else {
                        index++;
                }
        }
        // for sequentialNameSearch I can just make count1 equal to index + 1.  I can't usually do that.
        count1=index+1;

        if (index == wordArray.length) {
                count1=index;
        }
        // (index==wordArray.length) ? count1=index;


        if (!found) {
                System.out.println("iterativeBinarySearch()     "+'"'+wordSearch+'"'+" not found (comparison = "+count1+")");

                // word = "sequentialNameSearch()      " + '"'+wordSearch+'"'+" not found (comparison = "+count1+")";
        } else{
                System.out.println("sequentialNameSearch()      " + '"'+wordSearch+'"' +" is found in ["+index+"] (comparison = "+(index+1)+")");
        }
        return index;
}

public static int iterativeBinarySearch(String wordSearch) {
        /*

         */
        int first = 0;
        int last  = wordArray.length;
        count2 = 0;
        while (first < last) {
                int mid = (first + last) / 2;
                if (wordSearch.compareTo(wordArray[mid]) < 0) {
                        last = mid;
                        count2++;
                } else if (wordSearch.compareTo(wordArray[mid]) > 0) {
                        count2++;
                        first = mid + 1;
                } else {
                        System.out.println("iterativeBinarySearch()     "+'"'+wordSearch+'"'+ " is found in ["+mid+"] (comparison = "+count2+")");
                        return mid;
                }
        }
        System.out.println("iterativeBinarySearch()     "+'"'+wordSearch+'"'+" not found (comparison = "+count2+")");
        return -(first + 1);
}

public static int recursiveBinarySearch(String wordSearch,int low, int high){
        int index;
        count3++;
        int mid;
        if (high < low) {
                System.out.println("recursiveBinarySearch()     "+'"'+wordSearch+'"'+ " not found (comparison = "+count2+")");
                return -1;
        }
        mid = (low + high) / 2;

        // System.out.println("mid: "+ wordArray[mid] +", wordSearch: "+wordSearch + ", compare: "+wordArray[mid].compareTo(wordSearch));
        // System.out.println("count: "+ count3);
        if(wordArray[mid].compareTo(wordSearch) == 0) {
                // System.out.println("GOTCHA!");
                // System.out.println("Count: " + count3);
                System.out.println("recursiveBinarySearch()     "+'"'+wordSearch+'"'+ " is found in ["+mid+"] (comparison = "+count2+")");
                return mid;
        }
        else if (wordArray[mid].compareTo(wordSearch) > 0) {
                return recursiveBinarySearch(wordSearch, low, mid-1);
        }
        else if (wordArray[mid].compareTo(wordSearch) < 0) {
                return recursiveBinarySearch(wordSearch,mid+1,high);
        }
        else{
                System.out.println("recursiveBinarySearch()     "+'"'+wordSearch+'"'+ " is found in ["+mid+"] (comparison = "+count2+")");
                return mid;
        }
}

public static void main(String[] args) throws IOException, InterruptedException {
        /*

         */
        Scanner keyboard = new Scanner(System.in);
        boolean finished = false;
        if (wordArray == null) {
                finished = false;
        }
        while (!finished) {
                System.out.print("Type the filename to read: ");
                textFile = keyboard.nextLine();
                System.out.println(textFile);
                readFile();
                if (textFile.equals("q") || textFile.equals("TO_STOP")) {
                        finished = true;
                        System.out.println("Quitting");
                }
                else if (wordArray==null) {
                        System.out.print("File not found. ");
                }
                count1 = count2 = count3 = 0;
                while(wordArray!=null && finished == false) {
                        System.out.print("Type a word to search ("+ TO_STOP + " to stop): ");
                        String word2Search = keyboard.nextLine();
                        if (word2Search.equals(TO_STOP) || word2Search.equals("q")) {
                                finished = true;
                                System.out.println("Quitting");
                        }else{
                                sequentialNameSearch(word2Search);
                                iterativeBinarySearch(word2Search);

                                recursiveBinarySearch(word2Search, 0,wordArray.length);

                        }
                }


        }

/*

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
 */


        // System.out.println("pray for me");
}    // end of main()

}
