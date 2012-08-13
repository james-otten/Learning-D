/*
 * Find the sum of all the numbers that can be written as the sum of fifth powers of their digits (Euler 30)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

//Returns sum of each digit to the eth power
ulong powOfDigits(ulong n, ulong e) {
	ulong ret;
	while(n > 0) {
		ret += (n % 10) ^^ e;
		n /= 10;
	}
	return ret;
}

void main() {
	immutable ulong start = 2, pow = 5, end = powOfDigits(999999, 5);
	//immutable ulong start = 1_000, end = 10_000, pow = 4;
	ulong sum;
	for(ulong i = start; i < end; i++) {
		if(i == powOfDigits(i, pow))
			sum += i;
	}
	writeln("30: ", sum);
}
