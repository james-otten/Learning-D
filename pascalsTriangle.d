/*
 * Pascal's triangle and euler 15
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

//Return an array of n rows of pascal's triangle
long[][] pascalsTriangle(in ulong n) {
	long[][] ret;
	for(int i = 0; i < n; i++) {
		long[] row;
		for(int j = 0; j <= i; j++) {
			if(j == 0 || j == i)
				row ~= 1;
			else row ~= ret[$-1][j-1] + ret[$-1][j];
		}
		ret ~= row;
	}
	return ret;
}

unittest {
	assert(pascalsTriangle(5) == [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]);
}

//Main method for euler 15
void main() {
	immutable size = 20;
	auto pt = pascalsTriangle((size * 2) + 1);
	writeln("15: ", pt[size * 2][size]);	
}
