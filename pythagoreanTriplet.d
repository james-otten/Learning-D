/*
 * Finds Pythagorean triplets with a user defined sum
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

void main() {
	int input;
	write("Enter the sum of your desired Pythagorean triplet(s): ");
	readf("%d", &input);
	
	for(int i = 1; i < input - 2; i++) //Each side must be at least 1
		for(int j = i; j < input - 2; j++)
			if(i^^2 + j^^2 == (input - i - j)^^2)
				writefln("a=%d, b=%d, c=%d", i, j, input - i - j);
}
