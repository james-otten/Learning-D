/*
 * Which number from a range is missing?
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

//Returns the number that's missing from the range of positive numbers
T missing(T)(in T start, in T stop, in T[] numbers) {
	assert(numbers.length == (stop - start));
	T ret;
	for(T i = start; i < stop; i++)
		ret ^= i;
	for(T i = 0; i < numbers.length - 1; i++)
		ret ^= numbers[i];
	return ret;
}

unittest {
	assert((missing(-1, 5, [-1, 0, 1, 2, 3, 5]) == 4));
}

void main() {
	writeln(missing(-1, 5, [-1, 0, 1, 2, 3, 5]));
}
