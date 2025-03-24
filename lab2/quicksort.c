#include <stdio.h>

void quicksort(int arr[], int left, int right) {
    if (left >= right) return; // Warunek zakończenia - znaczniki się minęły

    int mid = left + (right - left) / 2; // Środek tablicy
    int pivot = arr[mid]; // Pivot

    // Zamiana pivota z ostatnim elementem
    int temp = arr[mid];
    arr[mid] = arr[right];
    arr[right] = temp;

    int i = left - 1;

    for (int j = left; j < right; j++){
        if (arr[j] < pivot){
            i++;
            // Zamiana elementów
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }

    int temp2 = arr[i + 1];
    arr[i + 1]= arr[right];
    arr[right] = temp2;

    int partIndex = i + 1;
    quicksort(arr, left, partIndex - 1);
    quicksort(arr, partIndex + 1, right);
}
