/*
 * Find the minimum path sum of a 2D matrix by moving down and right (Euler 81)
 *
 * Instead of recursing on an array working backwards like I did in 67,
 * I'll be using a directed weighted graph and dijkstra's algorithm.
 *
 * Copyright 2012 James Otten <james_otten@lavabit.com>
 */

import std.stdio;
import std.array;
import std.conv;
import std.string;

import weightedGraph;
import dijkstra;

//Template for this problem (some sizes call for ints, others for ulongs)
T findMinimumPathSum(T)(ref T[][] matrix) {
	//Helper: Converts array coordinates to number going right to left
	T nodeNumber(T i, T j, ulong len) {
		return (i * cast(T)len) + j;
	}
	//Build the graph
	auto graph = new WeightedGraph!T(true); //Directed because we can only move certain ways
	for(int i = 0; i < matrix.length; i++) {
		for(int j = 0; j < matrix[i].length; j++) {
			if(j + 1 < matrix[i].length)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i, j + 1, matrix[i].length), matrix[i][j + 1]); //To the right
			if(i + 1 < matrix.length)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i + 1, j, matrix[i].length), matrix[i + 1][j]); //Down
		}
	}
	//Do dijkstra
	//Second arg will always be 0 but call is for consistency (could break if someone changes numbering scheme)
	auto dijkstra = new Dijkstra!T(graph, nodeNumber(0, 0, 0));
	return matrix[0][0] + cast(T)dijkstra.distanceTo(nodeNumber(matrix.length - 1, matrix[0].length - 1, matrix.length)); //We never added the first node
}

/* Parse matrix from stdin
 * Format: commas separating items, newlines separating rows:
 * 1,2,3,4,5
 * 6,7,8,9,10
 * = [[1,2,3,4,5], [6,7,8,9,10]];
 */
void parseMatrix(T)(ref T[][] ret) {
	foreach(line; stdin.byLine()) {
		T[] row;
		foreach(num; line.split(",")) {
			row ~= to!T(num.strip()); //Supplied file uses windows style "\r\n"
		}
		ret ~= row;
	}
}

unittest {
	int[][] matrix = 	[[131, 673, 234, 103, 18],
				[201, 96, 342, 965, 150],
				[630, 803, 746, 422, 111],
				[537, 699, 497, 121, 956],
				[805, 732, 524, 37, 331]];
	assert(findMinimumPathSum!int(matrix) == 2427, "findMinimumPathSum() failed euler example.");
}

void main() {
	ulong[][] matrix;
	parseMatrix!ulong(matrix);
	writeln("81: ", findMinimumPathSum!ulong(matrix));
}
