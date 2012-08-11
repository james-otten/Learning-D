/*
 * Iteratively generates permutations (Euler 24 and 43)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

bool next_permutation(T)(ref T[] seq, in ulong first, in ulong last) {
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

ulong listToUlong(in ulong[] list) {
	ulong num;
	for(int x = 0; x < list.length; x++)
		num += list[x] * (10^^((list.length - 1) - x));
	return num;
}

/*
 * 1406357289
 * d2d3d4=406 is divisible by 2
 * d3d4d5=063 is divisible by 3
 * d4d5d6=635 is divisible by 5
 * d5d6d7=357 is divisible by 7
 * d6d7d8=572 is divisible by 11
 * d7d8d9=728 is divisible by 13
 * d8d9d10=289 is divisible by 17
 * Love how they're divisible by primes!
 */

void main() {
	ulong[] list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
	int[] divisableBy = [2, 3, 5, 7, 11, 13, 17];
	ulong i, sum, num;
	bool couldBe;
	do {
		//24
		if(++i == 1_000_000)
			writeln("24: ", listToUlong(list));
		//43
		couldBe = true;
		for(int j = 1; j < 8 && couldBe; j++) {
			num = 0;
			for(int k = 0; k < 3; k++)
				num += list[j + k] * (10^^(2 - k));
			if(num % divisableBy[j - 1] != 0)
				couldBe = false;
		}
		if(couldBe)
			sum += listToUlong(list);
	} while(next_permutation!(ulong)(list, 0, list.length));
	writeln("43: ", sum);
}
