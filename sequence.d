/*
 * Find the largest chain in a sequence starting from < 1000000  (Euler 14)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

/*
 * The sequence:
 *      for even n -> n/2
 *      for odd n  -> 3n+1
 * returns length of sequence
 * dict is a associative array: n -> length of sequence
 */
ulong sequence(ulong n, ref ulong[ulong] dict) {
	if(n in dict)
		return dict[n];
	else if(n % 2 == 0) {
		ulong temp = 1 + sequence(n / 2, dict);
		dict[n] = temp;
		return temp;
	} else {
		ulong temp = 1 + sequence(3 * n + 1, dict);
		dict[n] = temp;
		return temp;
	}
}

unittest {
	ulong[ulong] dict = [1:1, 2:2, 4:3];
	assert(sequence(13, dict) == 10, "sequence() failed on euler example");
}

void main() {
	ulong[ulong] dict = [1:1, 2:2, 4:3];
	ulong max = 1, maxIndex = 1, temp;
	for(int i = 1; i <= 1_000_000; i++) 
		if((temp = sequence(i, dict)) > max) {
			max = temp;
			maxIndex = i;
		}
	writeln(maxIndex);
}
