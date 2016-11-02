public class Sorting_Lab {
/** Sorting algorithms **/

// Insertion sort.

public static void insertionSort(int[] arr) {
        int i, j, newValue;
        for (i = 1; i < arr.length; i++) {
                newValue = arr[i];
                j = i;
                while (j > 0 && arr[j - 1] > newValue) {
                        arr[j] = arr[j - 1];
                        j--;
                }
                arr[j] = newValue;
        }
}

// Quicksort.

public static void quickSort(int[] array) {
        quickSort(array, 0, array.length - 1);
}

// Quicksort part of an array
private static void quickSort(int[] array, int begin, int end) {

        int index = partition(array, begin, end);
        if (begin < index - 1)
                quickSort(array, begin, index - 1);
        if (index < end)
                quickSort(array, index, end);
}

// Partition part of an array, and return the index where the pivot
// ended up.
private static int partition(int[] array, int begin, int end) {

        int i = begin, j = end;
        int tmp;
        int pivot = array[(begin + end) / 2];

        while (i <= j) {
                while (array[i] < pivot)
                        i++;
                while (array[j] > pivot)
                        j--;
                if (i <= j) {
                        tmp = array[i];
                        array[i] = array[j];
                        array[j] = tmp;
                        i++;
                        j--;
                }
        };

        return i;
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
private static int[] Merge(int[] left, int[] right)
{
        int[] result = new int[left.length + right.length];

        int l = 0, r = 0;   // keep track of the current idicies. if we would use a list we would just remove the elements.. but we are using arrays
        // as long as both arrays have elements, choose the smaller one
        while (left.length > l && right.length > r)
        {
                if (left[l] <= right[r])
                {
                        result[l + r] = left[l];
                        l++;
                }
                else
                {
                        result[l + r] = right[r];
                        r++;
                }
        }

        // then just add the remaining elements
        for (int i = l; i < left.length; i++)
        {
                result[l + r] = left[i];
                l++;
        }

        for (int i = r; i < right.length; i++)
        {
                result[l + r] = right[i];
                r++;
        }

        return result;
}
}
