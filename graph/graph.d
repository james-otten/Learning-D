/*
 * Adjacency list graph as class template.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.algorithm;

class Graph(T) {
	T[][T] SymbolTable; //Associative array holding vertices and edges: K=T; V=T[];

	this() {}

	//Adds vertex k
	void addVertex(T k) {
		SymbolTable[k] = []; //No edges to this vertex yet
	}
	//Adds edge from v to w
	void addEdge(T v, T w) {
		if(!exists(v))
			addVertex(v);
		if(!exists(w))
			addVertex(w);
		SymbolTable[v] ~= w;
		SymbolTable[w] ~= v;
	}
	//Returns array of vertices adjacent to k
	T[] adjacentTo(T k) {
		if(k in SymbolTable)
			return SymbolTable[k];
		else return [];
	}
	//Returns number of vertices in graph
	ulong numberVertices() {
		return SymbolTable.length;
	}
	//Returns number of edges in graph
	ulong numberEdges() {
		ulong count;
		foreach(k; SymbolTable.byKey) {
			count += SymbolTable[k].length;
		}
		return count / 2;
	}
	//Returns true if vertex is in graph
	bool exists(T vertex) {
		if (vertex in SymbolTable) //Not sure how to do this in one line :/
			return true;
		return false;
	}
	//Returns true if there is an edge from v to w
	bool exists(T v, T w) {
		return exists(v) && find(SymbolTable[v], w) != [];
	}
	//Returns the degree of given vertex (number of incident edges)
	ulong degree(T v) {
		return exists(v) ? adjacentTo(v).length : 0;
	}
}

unittest {
	auto graph = new Graph!(int)();
	//Test addEdge()
	graph.addEdge(1, 2);
	graph.addEdge(2, 3);
	//Test adjacentTo()
	assert(graph.adjacentTo(1) == [2]);
	assert(graph.adjacentTo(2) == [1, 3]);
	assert(graph.adjacentTo(-1) == []);
	//Test numberVertices()
	assert(graph.numberVertices() == 3);
	//Test numberEdges()
	assert(graph.numberEdges() == 2);
	//Test exists(1)
	assert(graph.exists(1));
	assert(graph.exists(2));
	assert(!graph.exists(-1));
	//Test exists(2)
	assert(graph.exists(1, 2));
	assert(graph.exists(2, 3));
	assert(!graph.exists(1, 3));
	assert(!graph.exists(-1, -2));
	//Test degree()
	assert(graph.degree(1) == 1);
	assert(graph.degree(2) == 2);
}
