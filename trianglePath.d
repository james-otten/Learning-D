/*
 * Euler 18 and 67
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;
import std.array;

long[][] parseTriangle() {
	long[][] ret;
	foreach(line; stdin.byLine()) {
		long[] row;
		foreach(num; line.split()) {
			row ~= to!long(num);
		}
		ret ~= row;
	}
	return ret;
}

long triangleSum(long[][] triangle) {
	if(triangle.length >= 2) {
		for(int i = 0; i <= triangle.length - 2; i++)
			triangle[$-2][i] += triangle[$-1][i] > triangle[$-1][i+1] ? triangle[$-1][i] : triangle[$-1][i+1];
		return triangleSum(triangle[0 .. $-1]);
	} else {
		return triangle[0][0];
	}
}

unittest {
	long[][] triangle = 	   [[3],
				  [7, 4],
				 [2, 4, 6],
				[8, 5, 9, 3]];
	assert(triangleSum(triangle) == 23);
}

void main() {
	long[][] triangle = 	[[75],
				[95, 64],
				[17, 47, 82],
				[18, 35, 87, 10],
				[20, 4, 82, 47, 65],
				[19, 1, 23, 75, 3, 34],
				[88, 2, 77, 73, 7, 63, 67],
				[99, 65, 4, 28, 6, 16, 70, 92],
				[41, 41, 26, 56, 83, 40, 80, 70, 33],
				[41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
				[53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
				[70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
				[91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
				[63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
				[4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23]];
	writeln("18: ", triangleSum(triangle));
	writeln("67: ", triangleSum(parseTriangle()));
	
}
