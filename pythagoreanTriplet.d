/*
 * Finds Pythagorean triplets with a user defined sum
 * Edited for euler 39
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

int numberPythagoreanTriplets(int p) {
	int ret;
	for(int i = 1; i < p - 2; i++) //Each side must be at least 1
		for(int j = i; j < p - 2; j++)
			if(i^^2 + j^^2 == (p - i - j)^^2)
				ret++;
	return ret;
}

//This is what this program used to do
void printPythagoreanTriplets(int input) {
	for(int i = 1; i < input - 2; i++) //Each side must be at least 1
		for(int j = i; j < input - 2; j++)
			if(i^^2 + j^^2 == (input - i - j)^^2)
				writefln("a=%d, b=%d, c=%d", i, j, input - i - j);
}

unittest {
	assert(numberPythagoreanTriplets(120) == 3, "numberPythagoreanTriplets() failed euler example");
}

void main() {
	int max = 3, maxIndex = 3, temp;
	for(int i = maxIndex; i <= 1000; i++)
		if((temp = numberPythagoreanTriplets(i)) > max) {
			max = temp;
			maxIndex = i;
		}
	writeln("39: ", maxIndex);
}
