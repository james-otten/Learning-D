/*
 * Euler 5
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

void main() {
	immutable number = 20;
	int[] divisors = [number];
	bool found;
	for(int i = number - 1; i > 1; i--) {
		found = false;
		foreach(d; divisors) {
			if(d % i == 0)
				found = true;
		}
		if(!found)
			divisors ~= i;
	}
	writeln("Divisors: ",divisors);
	int i = number;
	do {
		i++;
		found = true;
		foreach(d; divisors)
			if(i % d != 0) {
				found = false;
				break;
			}
	} while(!found);
	writeln("5: ", i);
}
