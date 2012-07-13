/*
 * Library import test program.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import graph;

void main() {
	auto graph = new Graph!(int)();
	graph.addEdge(1, 2);
	graph.addEdge(2, 3);
	writeln(graph.numberVertices());
}
