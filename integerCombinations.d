/*
 * Find the number of unique values in the set a^b for a and b from 2 to 100 (Euler 29)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.bigint;
import std.conv;

//Returns a ^ b
BigInt bigPow(BigInt b, BigInt e) {
	BigInt ret = b, E = e;
	while(E > 1) {
		ret = ret * b;
		E = E - 1;
	}
	return ret;
}

ulong uniqueCombinations(BigInt aStart, BigInt aEnd, BigInt bStart, BigInt bEnd) {
	bool[string] dict;
	for(BigInt a = aStart; a <= aEnd; a++)
		for(BigInt b = bStart; b <= bEnd; b++)
			dict[to!string(bigPow(a, b))] = true;
	return dict.keys.length;
}

unittest {
	assert(bigPow(BigInt("3"), BigInt("3")) == 27, "bigPow() failed");
	assert(uniqueCombinations(BigInt("2"), BigInt("5"), BigInt("2"), BigInt("5")) == 15, "uniqueCombinations() failed euler example");
}

void main() {
	writeln("29: ", uniqueCombinations(BigInt("2"), BigInt("100"), BigInt("2"), BigInt("100")));
}
