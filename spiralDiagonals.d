/*
 * What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way? (Euler 28)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
 */

import std.stdio;

long sumOfDiagonals(in long size) {
	assert(size > 0, "Negative sized spiral?");
	int sum = 1; // Middle
	for(int i = 3; i <= size; i += 2)
		for(int j = 0; j <= 3; j++)
			sum += i^^2 - (j * (i - 1));
	return sum;
}

unittest {
	assert(sumOfDiagonals(3) == 25, "sumOfDiagonals()");
	assert(sumOfDiagonals(5) == 101, "sumOfDiagonals()");
	assert(sumOfDiagonals(1001) == 669171001, "sumOfDiagonals()");
}

/*
 * (21) 22 23 24 (25)
 * 20 (7) 8 (9) 10
 * 19 6  (1) 2 11
 * 18 (5) 4 (3) 12
 * (17) 16 15 14 (13)
 *
 * What do you notice about the selected numbers of the _square_ ?
 * - The starting point of each diagonal is the distance between indexes of items on the diagonal squared.
 * - The diagonals are just the starting point: s - (N * (sqrt(s) - 1)) for N in (0 to 3)
 * I think this is my favorite Euler problem yet.
 */
void main() {
	writeln("28: ", sumOfDiagonals(1001));
}
