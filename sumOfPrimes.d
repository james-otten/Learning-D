/*
 * Calculates the sum of primes less than a given number
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.math;
import std.conv;

//Returns the sum of primes using sieveOfEratosthenes() below
ulong sumOfPrimes(in ulong max) {
	ulong ret;
	foreach(i, b; sieveOfEratosthenes(max))
		if(b)
			ret += i;
	return ret;
}

/* Sieve of Eratosthenes
 * Returns array of bools _indexed at 0_ which are true if the index is prime
 * 0 and 1 are not considered prime
 * 0 -> [false]
 * 1 -> [false, false]
 * 2 -> [false, false, true]
 */
bool[] sieveOfEratosthenes(in ulong max) { 
	ulong sqrtn = to!ulong(sqrt(to!double(max)));
	bool[] isPrime = new bool[max + 1];

	if(max < 2)
		return isPrime; //0 -> [false]; 1 -> [false, false]

	isPrime[] = true;
	for(ulong i = 2; i <= sqrtn; i++) {
		if(isPrime[i]) {
			for(ulong j = i * i; j <= max; j += i)
				isPrime[j] = false;
		}
	}
	isPrime[0] = isPrime[1] = false; //We're going to say that 0 and 1 aren't prime
	return isPrime;
}

unittest {
	assert(sieveOfEratosthenes(0) == [false]);
	assert(sieveOfEratosthenes(1) == [false, false]);
	assert(sieveOfEratosthenes(2) == [false, false, true]);
	assert(sumOfPrimes(10) == 17);
	assert(sumOfPrimes(2_000_000) == 142913828922);
}

void main() {
	ulong input;
	write("Enter a number to find the sum of primes below: ");
	readf("%d", &input);
	writefln("Sum of primes below %d: %d", input, sumOfPrimes(input));
}
