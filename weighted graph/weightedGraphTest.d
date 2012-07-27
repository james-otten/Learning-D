/*
 * Tests WeightedGraph and Dijkstra
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import weightedGraph;
import dijkstra;

void main() {
	auto graph = new WeightedGraph!int(false);

	//https://upload.wikimedia.org/wikipedia/commons/4/45/Dijksta_Anim.gif
	graph.addEdge(1, 2, 7);
	graph.addEdge(1, 3, 9);
	graph.addEdge(1, 6, 14);
	graph.addEdge(2, 3, 10);
	graph.addEdge(2, 4, 15);
	graph.addEdge(3, 4, 11);
	graph.addEdge(3, 6, 2);
	graph.addEdge(4, 5, 6);
	graph.addEdge(5, 6, 9);

	auto dijkstra = new Dijkstra!int(graph, 1);
	
	for(int i = 1; i <=6; i++) {
		writefln("Distance from %d to %d is %d", 1, i, dijkstra.distanceTo(i));
	}

	writeln();
	for(int i = 1; i <=6; i++) {
		writefln("Path from %d to %d is %s", 1, i, dijkstra.pathTo(i));
	}
}
