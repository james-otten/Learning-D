/*
 * Find the largest plaindrome made from the product of two 3 digit numbers (Euler 4)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;
import std.string;

bool isPlaindrome(int n) {
	string s = to!string(n);
	return 0 == icmp(s, s.dup.reverse);
}

unittest {
	assert(isPlaindrome(101), "isPlaindrome() failed");
	assert(!isPlaindrome(110), "isPlaindrome() false positive");
}

void main() {
	int max, temp;
	for(int i = 999; i > 99; i--)
		for(int j = 999; j > 99; j--) {
			if((temp = i * j) > max && isPlaindrome(temp))  //0m0.841s -> 0m0.011s by checking temp > max first
				max = temp;
		}
	writeln("4: ", max);
}
