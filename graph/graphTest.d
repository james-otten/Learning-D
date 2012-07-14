/*
 * Library import test program.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import graph;
import breadthFirstSearch;

void showDistance(T)(BreadthFirstSearch!(T) bfs, T to) {
	writeln("Distance from ", bfs.me, " to ", to, ": ", bfs.distanceTo(to));
}

void main() {
	auto graph = new Graph!(int)();
	graph.addEdge(1, 2);
	graph.addEdge(2, 3);
	graph.addEdge(2, 4);
	graph.addEdge(4, 5);
	graph.addEdge(2, 5);

	auto bfs = new BreadthFirstSearch!(int)(graph, 1);
	for(int i = 1; i <= 5; i++)
		showDistance!(int)(bfs, i);
	for(int i = 1; i <= 5; i++)
		writeln("Path from ", bfs.me, " to ", i, ": ", bfs.pathTo(i));
}
