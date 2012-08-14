/*
 * What is the value of the first triangle number to have over five hundred divisors? (Euler 12)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.math;

//Return the number of divisors of n
ulong numDivisors(in ulong n) {
	ulong divs = 0;
	ulong N = n;
	for(ulong i = cast(ulong)n ^^ .5; i > 0; i--) {
		if(n % i == 0)
			divs += 2;
	}
	if((cast(ulong)n ^^ .5) ^^ 2 == n)
		divs--;
	return divs;
}

//Return the first triangle number with more divisors than gtDivisors
ulong firstTriangleMoreDivisors(in ulong gtDivisors) {
	ulong n = 1, triangle = 1;
	while(numDivisors(triangle) < gtDivisors) {
		triangle += ++n;
	}
	return triangle;
}

unittest {
	assert(numDivisors(28) == 6, "numDivisors() failed");
	assert(firstTriangleMoreDivisors(5) == 28, "firstTriangleMoreDivisors() failed euler example");
}

void main() {
	writeln(firstTriangleMoreDivisors(500));
}
