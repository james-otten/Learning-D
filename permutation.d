/*
 * Iteratively generates permutations
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

bool next_permutation(T)(ref T[] seq, ulong first, ulong last) {
	void swap(ref T[] arr, in ulong a, in ulong b) {
		T temp = arr[a];
		arr[a] = arr[b];
		arr[b] = temp;
	}

	if(first == last) return false;
	ulong i = first;
	i++;
	if(i == last) return false;
	i = last;
	i--;
	
	for(;;) {
		ulong ii = i;
		i--;
		if(seq[i] < seq[ii]) {
			ulong j = last;
			while(!(seq[i] < seq[--j])){};
			swap(seq, i, j);
			seq[ii..last].reverse;
			return true;
		}
		if(i == first) {
			seq[first..last].reverse;
			return false;
		}
	}
}

void main() {
	int[] list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
	int i;
	do {
		if(++i == 1_000_000) {
			writeln(list);
			break;
		}
	} while(next_permutation!(int)(list, 0, list.length));
}
