/*
 * Number of times it was a Sunday on the first of the month in the 20th century (Euler 19)
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.datetime;

void main() {
	auto date = DateTime(1901, 1, 1);
	auto end = DateTime(2000, 12, 31);
	int count;
	do {
		if(date.dayOfWeek == 0) {
			writeln(date);
			count++;
		}
		date.add!"months"(1);		
	} while(date < end);
	writeln("There were ", count, " Sundays that fell on the first of the month in the 20th century.");
	
}
