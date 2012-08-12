/*
 * In the chain where the next term is the sum of the square of each digit,
 * how many starting numbers below 10 million arrive at 89? (Euler 92)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

//Note: I tried using an associative array to cache values but that doubled the execution time

import std.stdio;

//Returns the sum of the square of each digit
ulong sumOfSquareOfDigits(ulong n) {
	ulong ret;
	while(n > 0) {
		ret += (n % 10) ^^ 2;
		n /= 10;
	}
	return ret;
}

//Returns true if the chain ends at 1
bool endsAtOne(in ulong n) {
	bool endsAtOneRec(in ulong n, in bool seenOne, in bool seenEighty) {
		ulong val = sumOfSquareOfDigits(n);
		if(val == 1) {
			if(seenOne)
				return true;
			else return endsAtOneRec(val, true, seenEighty);
		}
		else if(val == 89) {
			if(seenEighty)
				return false;
			else return endsAtOneRec(val, seenOne, true);
		}
		return endsAtOneRec(val, seenOne, seenEighty);
	}
	return endsAtOneRec(n, false, false);
}

unittest {
	assert(endsAtOne(44), "endsAtOne() failed euler example");
	assert(!endsAtOne(85), "endsAtOne() failed euler example");
}

void main() {
	//Given the chain always ends at 89 or 1
	ulong endsAtEighty;
	for(ulong i = 1; i <= 10_000_000; i++)
		if(!endsAtOne(i))
			endsAtEighty++;
	writeln("92: ", endsAtEighty);
}
