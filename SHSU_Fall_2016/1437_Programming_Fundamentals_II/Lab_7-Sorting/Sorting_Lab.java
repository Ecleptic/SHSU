public class Sorting_Lab {
    /** Sorting algorithms **/

    // Insertion sort.

    public static void insertionSort(int[] array) {
        throw new UnsupportedOperationException();
    }

    // Quicksort.

    public static void quickSort(int[] array) {
        quickSort(array, 0, array.length - 1);
    }

    // Quicksort part of an array
    private static void quickSort(int[] array, int begin, int end) {
        // Base case.
        if (begin >= end) return;

        // Partition the array.
        int pivot = partition(array, begin, end);

        // Now recursively quicksort the two partitions.
        throw new UnsupportedOperationException();
    }

    // Partition part of an array, and return the index where the pivot
    // ended up.
    private static int partition(int[] array, int begin, int end) {
        // array[begin] will be the pivot element
        int low = begin+1;
        int high = end;

        throw new UnsupportedOperationException();
    }

    // Swap two elements in an array
    private static void swap(int[] array, int i, int j) {
        int x = array[i];
        array[i] = array[j];
        array[j] = x;
    }

    // Mergesort.

    public static int[] mergeSort(int[] array) {
        return mergeSort(array, 0, array.length - 1);
    }

    // Mergesort part of an array
    private static int[] mergeSort(int[] array, int begin, int end) {
        // Base case: array of length 0 or 1.
        if (begin > end) return new int[0];
        if (begin == end) {
            int[] result = {array[begin]};
            return result;
        }

        // Midpoint of the array
        int mid = (begin+end)/2;

        // Recursively sort both halves of the array,
        // then merge the results.
        throw new UnsupportedOperationException();
    }

    // Merge two sorted arrays into one
    private static int[] merge(int[] left, int[] right) {
        // The result array
        int[] result = new int[left.length + right.length];
        // How far we have got in the result array
        int nextResult = 0;
        // How far we have got in the left array
        int nextLeft = 0;
        // How far we have got in the right array
        int nextRight = 0;

        // Idea: repeatedly copy one element from either the left or right array to the result array.
        throw new UnsupportedOperationException();
    }
}
