/*
 * Find the minimum path sum of a 2D matrix by moving right and down from NW to SE (Euler 81)
 * 
 * Find the minimum path sum of a 2D matrix from the left column to the right column (Euler 82)
 *
 * Find the minimum path sum of a 2D matrix by moving left, right, up, and down from NW to SE (Euler 83)
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

//Template for 81
T findMinimumPathSumRightDown(T)(ref T[][] matrix) {
	//Build the graph
	auto graph = new WeightedGraph!T(true); //Directed because we can only move certain ways
	//Make numbers for the virtual nodes
	immutable T start = nodeNumber!T(0, 0, matrix.length);
	immutable T end = nodeNumber!T(matrix.length - 1, matrix.length - 1, matrix.length);
	//Fill in the rest of the nodes
	addNodes!T(graph, matrix, false, true, true, false);
	//Do dijkstra
	auto dijkstra = new Dijkstra!T(graph, start);
	return cast(typeof(return))dijkstra.distanceTo(end) + matrix[0][0]; //We never added the first node
}

//Template for 82
T findMinimumPathSumLeftRight(T)(ref T[][] matrix) {
	//Build the graph
	auto graph = new WeightedGraph!T(true); //Directed because we can only move certain ways
	//Make numbers for the virtual nodes
	immutable T start = cast(T)(matrix.length ^^ 2 + 1);
	immutable T end = cast(T)(matrix.length ^^ 2 + 2);
	//Fill in the virtual nodes
	for(int i = 0; i < matrix.length; i++) {
		graph.addEdge(start, nodeNumber!T(i, 0, matrix.length), matrix[i][0]);// virtual start -> each left
		graph.addEdge(nodeNumber!T(i, matrix.length - 1, matrix.length), end, 0);// each right -> virtual end
	}
	//Fill in the rest of the nodes
	addNodes!T(graph, matrix, true, true, true, false);
	//Do dijkstra
	auto dijkstra = new Dijkstra!T(graph, start);
	return cast(typeof(return))dijkstra.distanceTo(end);
}

//Template for 83
T findMinimumPathSumAll(T)(ref T[][] matrix) {
	//Build the graph
	auto graph = new WeightedGraph!T(true); //Directed because we can only move certain ways
	//Make numbers for the virtual nodes
	immutable T start = nodeNumber!T(0, 0, matrix.length);
	immutable T end = nodeNumber!T(matrix.length - 1, matrix.length - 1, matrix.length);
	//Fill in the rest of the nodes
	addNodes!T(graph, matrix, true, true, true, true);
	//Do dijkstra
	auto dijkstra = new Dijkstra!T(graph, start);
	return cast(typeof(return))dijkstra.distanceTo(end) + matrix[0][0]; //We never added the first node
}


//Helper: Converts array coordinates to number going right to left
T nodeNumber(T)(T i, T j, ulong len) {
	return cast(T)((i * len) + j);
}
	
//Helper: Adds nodes to graph
void addNodes(T)(WeightedGraph!T graph, ref T[][] matrix, bool up, bool down, bool right, bool left) {
	for(int i = 0; i < matrix.length; i++)
		for(int j = 0; j < matrix[i].length; j++) {
			if(left && j - 1 >= 0)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i, j - 1, matrix[i].length), matrix[i][j - 1]); //Left
			if(right && j + 1 < matrix[i].length)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i, j + 1, matrix[i].length), matrix[i][j + 1]); //Right
			if(down && i + 1 < matrix.length)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i + 1, j, matrix[i].length), matrix[i + 1][j]); //Down
			if(up && i - 1 >= 0)
				graph.addEdge(nodeNumber(i, j, matrix[i].length), nodeNumber(i - 1, j, matrix[i].length), matrix[i - 1][j]); //Up
		}
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
	ulong[][] matrix = 	[[131, 673, 234, 103, 18],
				[201, 96, 342, 965, 150],
				[630, 803, 746, 422, 111],
				[537, 699, 497, 121, 956],
				[805, 732, 524, 37, 331]];
	assert(findMinimumPathSumRightDown!ulong(matrix) == 2427, "findMinimumPathSum() failed euler example.");
	assert(findMinimumPathSumLeftRight!ulong(matrix) == 994, "findMinimumPathSumLeftRight() failed euler example.");
	assert(findMinimumPathSumAll!ulong(matrix) == 2297, "findMinimumPathSumAll() failed euler example.");
}

void main() {
	ulong[][] matrix;
	parseMatrix!ulong(matrix);
	writeln("81: ", findMinimumPathSumRightDown!ulong(matrix));
	writeln("82: ", findMinimumPathSumLeftRight!ulong(matrix));
	writeln("83: ", findMinimumPathSumAll!ulong(matrix));
}
