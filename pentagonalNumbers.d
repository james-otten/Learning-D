/*
 * Find the pair of pentagonal numbers, Pj and Pk, for which their sum and difference is pentagonal and D = |Pk - Pj| is minimised; what is the value of D? (Euler 44)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
 */

import std.stdio;
import std.array;
import std.math;

long pentagonal(in long n) {
	return (n * ((3 * n) - 1)) / 2;
}

bool isPentagonal(in long n) {
	return (((sqrt(cast(float)(24 * n + 1)) + 1) / 6) % 1) == 0;
}

unittest {
	assert(pentagonal(1) == 1, "pentagonal()");
	assert(pentagonal(2) == 5, "pentagonal()");
	assert(pentagonal(3) == 12, "pentagonal()");
	assert(pentagonal(4) == 22, "pentagonal()");
	for(int i = 1; i < 10; i++)
		assert(isPentagonal(pentagonal(i)), "isPentagonal()");
}

/*
 * On my system, maintaining the array nums is about 4 ms faster than calculating the value each time:
 * Intel(R) Core(TM)2 Duo CPU P7550  @ 2.26GHz  //I need a new Laptop :/
 * DMD64 D Compiler v2.059
 * dmd pentagonalNumbers.d -inline -O -release
 * real	0m0.066s
 * user	0m0.064s
 * sys	0m0.001s
 */
void main() {
	long[] nums = [1, 5, 12, 22];
	long j, k = 1;
	bool found;
	do {
		//Next index to test
		k++; 
		//Grow nums as needed
		while(nums[$-1] < (nums[k-1] + nums[k]))
			nums ~= pentagonal(nums.length + 1);
		//Check k against all
		for(j = k - 1; j > 0; j--) {
			if(isPentagonal(nums[j] + nums[k]) && isPentagonal(nums[k] - nums[j])) {
					found = true;
					break;
			}
		}
	} while(!found);
	writeln("44: D = |Pk - Pj| = |", nums[k] , " - ", nums[j], "| = ", nums[k] - nums[j]);
}
