/*
 * Various sorting algorithms 
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;
import std.random;
import std.datetime;

//Swap index i and j in arr
void swap(ref ulong[] arr, ulong i, ulong j) {
	ulong temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
}

//Return the largest value from arr
ulong maxValue(ref ulong[] arr) {
	ulong max;
	foreach(ul; arr)
		if(ul > max)
			max = ul;
	return max;
}

/*
 * Insertion Sort 
 * Worst: O(n^2)
 * Best: O(n)
 * Average: O(n^2)
 */
void insertionSort(ref ulong[] arr) {
	for(ulong i = 1; i < arr.length; i++)
		for(ulong j = i; j > 0 && arr[j - 1] > arr[j]; j--)
			swap(arr, j, j - 1);
}

/*
 * Bubble Sort 
 * Worst: O(n^2)
 * Best: O(n^2)
 * Average: O(n^2)
 */
void bubbleSort(ref ulong[] arr) {
	for(ulong i = 0; i < arr.length - 1; i++)
		for(ulong j = arr.length - 1; j > i; j--)
			if(arr[j - 1] > arr[j])
				swap(arr, j, j - 1);
}

/*
 * Selection Sort 
 * Worst: O(n^2)
 * Best: O(n^2)
 * Average: O(n^2)
 */
void selectionSort(ref ulong[] arr) {
	for(ulong i = 0; i < arr.length - 1; i++) {
		ulong index = i;
		for(ulong j = arr.length - 1; j > i; j--)
			if(arr[j] < arr[index])
				index = j;
		swap(arr, i, index);
	}
}

/*
 * Shellsort 
 * Worst: O(n^1.5)
 * Best: O(n^1.5)
 * Average: O(n^1.5)
 */
void shellsort(ref ulong[] arr) {
	void insertion(ref ulong[] arr, ulong n, ulong increment) {
		for(ulong i = increment; i < n; i += increment)
			for(ulong j = i; j >= increment && arr[j] < arr[j - increment]; j -= increment)
				swap(arr, j, j - increment);
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
void mergeSort(ref ulong[] arr) {
	void merge(ref ulong[] arr, ref ulong[] temp, ulong left, ulong right) {
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
	ulong[] temp = new ulong[arr.length];
	merge(arr, temp, 0UL, arr.length - 1);
}

/*
 * Radix Sort (LSD)
 * Worst: O(kn)
 * Best: O(kn)
 */
void radixSort(ref ulong[] arr) {
	if(arr.length == 0)
		return;
	//ulong[][] buckets;
	//buckets.length = 10;
	ulong[][10] buckets;
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
	auto funcs = [&insertionSort, &bubbleSort, &selectionSort, &shellsort, &mergeSort, &radixSort];

	foreach(i, f; funcs) {
		assert(testSortingAlgorithm(test, answer, f), "Sorting function index " ~ to!string(i) ~ " failed");
		assert(testSortingAlgorithm(test2, answer2, f), "Sorting function index " ~ to!string(i) ~ " failed");
	}
}

void main() {
	auto funcs = [&insertionSort, &bubbleSort, &selectionSort, &shellsort, &mergeSort, &radixSort];
	auto names = ["Insertion Sort", "Bubble Sort", "Selection Sort", "Shellsort", "Merge Sort", "Radix Sort (LSD)"];
	ulong[] data;
	ulong values;

	writeln("Enter the number of random values to sort:");
	readf("%d", &values);

	for(ulong i = 0; i < values; i++)
		data ~= uniform(0, ulong.max);

	foreach(i, f; funcs) {
		auto temp = data.dup;
		auto start = Clock.currTime();
		f(temp);
		auto end = Clock.currTime();
		writeln(names[i] ~ ":   " ~ to!string(end - start));
	}	
}
