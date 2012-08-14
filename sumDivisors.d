/*
 * Evaluate the sum of all the amicable numbers under 10000. (Euler 21)
 * TODO: Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers. (Euler 23)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

//Return the sum of the proper divisors of n
ulong sumDivisors(in ulong n) {
	ulong sum;
	for(ulong i = cast(ulong)n ^^ .5; i > 1; i--) {
		if(n % i == 0)
			sum += i + n / i; //Add i and the other factor
	}
	return sum + 1;//Don't forget about 1
}

//Returns true if x and y are amicable
//dict is an associative array of: input -> sum-of-divisors used to cache sumDivisors() calls
bool areAmicable(in ulong x, in ulong y, ref ulong[ulong] dict) {
	if(x == y)
		return false;
	if(x !in dict)
		dict[x] = sumDivisors(x);
	if(y !in dict)
		dict[y] = sumDivisors(y);
	return dict[x] == y && dict[y] == x;
}

//Return the sum of amicalbe numbers under max
ulong sumAmicableNumbersUnder(in ulong max) {
	ulong sum;
	ulong[ulong] dict;
	for(ulong i = 1; i < max; i++)
		for(ulong j = i + 1; j < max; j++) //All pairs would get us double the answer and this is faster
			if(areAmicable(i, j, dict))
				sum += i + j;
	return sum;
}

bool isAbundant(in ulong n) {
	return n < sumDivisors(n);
}

bool canBeWrittenAsSumOfTwoAbundantNumbers(in ulong n, ref ulong[] abundants) {
	for(ulong i = 0; i < abundants.length && abundants[0] + abundants[i] <= n; i++)
		for(ulong j = i; j < abundants.length; j++) {
			if(abundants[i] + abundants[j] == n)
				return true;
			else if(abundants[i] + abundants[j] > n)
				break;
		}
	return false;
}

unittest {
	//Test sumDivisors()
	assert(sumDivisors(220) == 284, "sumDivisors() failed euler example");
	assert(sumDivisors(284) == 220, "sumDivisors() failed euler example");
	//Test areAmicable()
	ulong[ulong] dict;
	assert(areAmicable(220, 284, dict), "areAmicable() failed euler example");
	assert(!areAmicable(220, 1, dict), "areAmicable() false positive");
	//Test isAbundant()
	assert(isAbundant(12), "isAbundant() failed");
	assert(!isAbundant(15), "isAbundant() false positive");
}

void main() {
	//writeln("21: ", sumAmicableNumbersUnder(10_000));
	//TODO: This isn't working
	immutable ulong MAX = 28123; //Using "By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers."
	ulong sum;
	ulong[] abundantNumbers;
	ulong[MAX] nums;
	//bool[MAX] numbers;
	for(int i = 0; i <= MAX; i++)
		nums[i] = i + 1;
	for(int i = 12; i < MAX; i++)
		if(isAbundant(i))
			abundantNumbers ~= i;
	for(int i = 0; i < abundantNumbers.length; i++) {
		if(abundantNumbers[i] + abundantNumbers[0] > MAX) {
			break;
		}
		for(int j = 0; j < abundantNumbers.length; j++) {
			if(abundantNumbers[i] + abundantNumbers[j] < nums.length) {
				//numbers[abundantNumbers[i] + abundantNumbers[j] - 1] = true; //-1 because zero index
				nums[abundantNumbers[i] + abundantNumbers[j]] = 0; //-1 because zero index
			}
			else if(abundantNumbers[i] + abundantNumbers[j] > MAX)
				break;
		}
	}
	for(int i = 0; i < MAX; i++)
		//if(!numbers[i]) {
		sum += nums[i];
		//	sum += i + 1;
			//writeln(i + 1);
	//}
	writeln("23: ", sum);writeln(nums[24]);
}
