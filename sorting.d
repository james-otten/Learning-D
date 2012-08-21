/*
 * Various sorting algorithms 
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;
import std.random;
import std.datetime;

//Swap index i and j in arr
void swap(T)(ref T[] arr, ulong i, ulong j) {
	T temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
}

//Return the largest value from arr
ulong maxValue(T)(ref T[] arr) {
	T max;
	foreach(ul; arr)
		if(ul > max)
			max = ul;
	return max;
}

//Make sure arr is sorted ascendingly
bool isSorted(T)(ref T[] arr) {
	ulong i = 1;
	while(i < arr.length)
		if(arr[i] < arr[i++ - 1]) //If this one is smaller than the last
			return false;
	return true;
}

/*
 * Insertion Sort 
 * Worst: O(n^2)
 * Best: O(n)
 * Average: O(n^2)
 */
void insertionSort(T)(ref T[] arr) {
	for(ulong i = 1; i < arr.length; i++)
		for(ulong j = i; j > 0 && arr[j - 1] > arr[j]; j--)
			swap!T(arr, j, j - 1);
}

/*
 * Bubble Sort 
 * Worst: O(n^2)
 * Best: O(n^2)
 * Average: O(n^2)
 */
void bubbleSort(T)(ref T[] arr) {
	for(ulong i = 0; i < arr.length - 1; i++)
		for(ulong j = arr.length - 1; j > i; j--)
			if(arr[j - 1] > arr[j])
				swap!T(arr, j, j - 1);
}

/*
 * Selection Sort 
 * Worst: O(n^2)
 * Best: O(n^2)
 * Average: O(n^2)
 */
void selectionSort(T)(ref T[] arr) {
	for(ulong i = 0; i < arr.length - 1; i++) {
		ulong index = i;
		for(ulong j = arr.length - 1; j > i; j--)
			if(arr[j] < arr[index])
				index = j;
		swap!T(arr, i, index);
	}
}

/*
 * Shellsort 
 * Worst: O(n^1.5)
 * Best: O(n^1.5)
 * Average: O(n^1.5)
 */
void shellsort(T)(ref T[] arr) {
	void insertion(ref T[] arr, ulong n, ulong increment) {
		for(ulong i = increment; i < n; i += increment)
			for(ulong j = i; j >= increment && arr[j] < arr[j - increment]; j -= increment)
				swap!T(arr, j, j - increment);
	}
	for(ulong i = arr.length / 3; i > 3; i /= 3)
		for(ulong j = 0; j < i; j++)
			insertion(arr, arr.length - j, i);
	insertion(arr, arr.length, 1);
}

/*
 * Merge Sort 
 * Worst: O(n log n)
 * Best: O(n)
 * Average: O(n log n)
 */
void mergeSort(T)(ref T[] arr) {
	void merge(ref T[] arr, ref T[] temp, ulong left, ulong right) {
		if(left == right)
			return;
		ulong mid = (left + right) / 2;
		merge(arr, temp, left, mid);
		merge(arr, temp, mid + 1, right);
		for(ulong i = left; i <= right; i++)
			temp[i] = arr[i];
		ulong i = left, j = mid + 1;
		for(ulong cur = left; cur <= right; cur++) {
			if(i == mid + 1)
				arr[cur] = temp[j++];
			else if(j > right)
				arr[cur] = temp[i++];
			else if(temp[i] < temp[j])
				arr[cur] = temp[i++];
			else arr[cur] = temp[j++];
		}
	}
	auto temp = new T[arr.length];
	merge(arr, temp, 0UL, arr.length - 1);
}

/*
 * Radix Sort (LSD)
 * Worst: O(kn)
 * Best: O(kn)
 */
void radixSort(T)(ref T[] arr) {
	if(arr.length == 0)
		return;
	T[][10] buckets;
	ulong powTen = 1;
	ulong max = maxValue(arr);
	for(; max != 0; max /= 10, powTen *= 10) {
		foreach(elem; arr) {
			buckets[(elem / powTen) % 10] ~= elem;
		}
		ulong store_index = 0;
		foreach(bucket; buckets) {
			foreach(bucket_elem; bucket) {
				arr[store_index++] = bucket_elem;
			}
		}
		buckets[] = [];
	}
}

/*
 * Quicksort
 * Worst: O(n^2)
 * Best: O(n log n)
 * Average: O(n log n)
 */
void quicksort(T)(ref T[] arr) {
	ulong partition(ref T[] arr, ulong left, ulong right, ulong pivotIndex) {
		T pivotValue = arr[pivotIndex];
		swap!T(arr, pivotIndex, right);
		ulong storeIndex = left;
		for(ulong i = left; i < right; i++)
			if(arr[i] < pivotValue)
				swap!T(arr, i, storeIndex++);
		swap!T(arr, storeIndex, right);
		return storeIndex;
	}
	void quick(ref T[] arr, ulong left, ulong right) {
		if(left < right) {
			ulong pivot = left + (right - left) / 2;
			pivot = partition(arr, left, right, pivot);
			if(pivot != 0) {
			quick(arr, left, pivot - 1);
			quick(arr, pivot + 1, right);}
		}
	}
	quick(arr, 0UL, arr.length - 1);
}

unittest {
	//Helper for testing sorting functions
	bool testSortingAlgorithm(ulong[] test, ulong[] answer, void function(ref ulong[]) func) {
		auto temp = test.dup;
		func(temp);
		if(temp != answer)
			writeln(temp);
		return temp == answer;
	}
	ulong[] test = [1, 9, 2, 10, 5, 3];
	ulong[] answer = [1, 2, 3, 5, 9, 10];
	ulong[] test2 = 11 ~ answer;
	ulong[] answer2 = answer ~ 11;
	auto funcs = [&insertionSort!ulong, &bubbleSort!ulong, &selectionSort!ulong, &shellsort!ulong, &mergeSort!ulong, &radixSort!ulong, &quicksort!ulong];

	foreach(i, f; funcs) {
		assert(testSortingAlgorithm(test, answer, f), "Sorting function index " ~ to!string(i) ~ " failed");
		assert(testSortingAlgorithm(test2, answer2, f), "Sorting function index " ~ to!string(i) ~ " failed");
	}
	assert(!isSorted(test), "isSorted() failed");
	assert(isSorted(answer), "isSorted() failed");
}

void main() {
	auto funcs = [&insertionSort!int, &bubbleSort!int, &selectionSort!int, &shellsort!int, &radixSort!int, &mergeSort!int, &quicksort!int];
	auto names = ["Insertion Sort", "Bubble Sort", "Selection Sort", "Shellsort", "Radix Sort", "Merge Sort", "Quicksort"];
	int[] data;
	ulong values;

	writeln("Enter the number of random values to sort:");
	readf("%d", &values);

	for(ulong i = 0; i < values; i++)
		data ~= uniform(0, int.max);

	foreach(i, f; funcs) {
		auto temp = data.dup;
		auto start = Clock.currTime();
		f(temp);
		auto end = Clock.currTime();
		if(isSorted(temp))
			writeln(names[i] ~ ":\t\t" ~ to!string(end - start));
		else writeln("Failed " ~ names[i] ~ ":\t\t" ~ to!string(end - start));
	}
}
