/*
 * Higher order fibonacci numbers.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

//Returns the nth fibonacci number of order k
ulong fib(in ulong k, in ulong n) {
	assert(k > 1);
	assert(n > 0);

	ulong[] seq = [];
	for(ulong i = 0; i <= k - 1; i++)
		seq ~= 0;
	seq ~= 1;
	for(ulong i = k; i < n+1; i++) {
		ulong element;
		for(long j = 1; j < k+1; j++) {
			element += seq[$-j];
		}
		seq ~= element;
	}
	return seq[n];
}

void main() {
	//writeln(fib(3, 5));
	ulong k, n;
	writeln("Enter the order of the higher order fibonacci sequence:");
	stdin.readf(" %d", &k);
	writeln("Enter the term you'd like:");
	stdin.readf(" %d", &n);
	writefln("Answer: %d", fib(k,n));
}
