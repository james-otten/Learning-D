/*
 * Euler 13
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;
import std.array;
import std.bigint;

//Gets one number per line
BigInt[] parseNumbers() {
	typeof(return) ret;
	foreach(line; stdin.byLine()) {
		BigInt t = to!string(line);
		ret ~= t;
	}
	return ret;
}

//Returns sum of array
BigInt sum(BigInt[] array) {
	typeof(return) ret;
	foreach(l; array) 
		ret = ret + l;
	return ret;
}

unittest {
	assert(sum(["1", "2", "3"]) == 6);
}

void main() {
	immutable digits = 10;
	writeln("13: ", to!string(sum(parseNumbers()))[0..10]);
	
}
