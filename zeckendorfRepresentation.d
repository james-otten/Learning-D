/*
 * Finds the Zeckendorf Representation of a given number.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/


import std.stdio;

int[] fibonacciTo(int n) {
	int[] seq = [0, 1];
	int next;
	if(n == 0)
		return seq[0 .. 1];
	while(true) {
		next = seq[$-2] + seq[$-1];
		if(next <= n)
			seq ~= next;
		else break;
	}
	return seq;
}

//n: The number we're looking for the Zeckendorf Representation of.
//seq: The fibonacci sequence up to n in reverse order
int[] zeckendorfRepresentation(int n, ref int[] seq) {
	//Prune our sequence such that all (the first) element is less than n
	while(seq[0] > (n))
		seq = seq[1 .. $];
	//End case, out of numbers
	if(seq[0] == 0) return [];
	//Add the next element, recourse 
	int next = seq[0];		
	return next ~ zeckendorfRepresentation(n - next, seq);
}

void main() {
	int number = 3^^15;
	int[] seq = fibonacciTo(number).reverse;
	writeln(zeckendorfRepresentation(number, seq));
}
