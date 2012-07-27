/*
 * Adjacency list, directed _or_ undirected, weighted graph as class template.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

module weightedGraph;

import std.stdio;
import std.algorithm;

class WeightedGraph(T) {
	private ulong[T] [T] SymbolTable; //Maps T -> (Map of T -> ulong)
	private bool directed;

	this() {} //directed = false
	this(bool isDirectedGraph) { directed = isDirectedGraph; }

	//Adds vertex k
	void addVertex(in T k) {
		ulong[T] adj;
		SymbolTable[k] = adj;
	}
	//Adds edge from a to b
	void addEdge(in T a, T b, in ulong weight) {
		if(!exists(a))
			addVertex(a);
		if(!exists(b))
			addVertex(b);
		auto adj = SymbolTable[a];
		adj[b] = weight;
		SymbolTable[a] = adj;

		if(!directed) {
			adj = SymbolTable[b];
			adj[a] = weight;
			SymbolTable[b] = adj;
		}
	}
	//Returns associative array of vertices adjacent to k (T -> weight)
	ulong[T] adjacentTo(in T k) {
		if(k in SymbolTable)
			return SymbolTable[k];
		else {
			ulong[T] empty;
			return empty;
		}
	}
	//Returns number of vertices in graph
	ulong numberVertices() const {
		return SymbolTable.length;
	}
	//Returns number of edges in graph
	ulong numberEdges() const {
		ulong count;
		foreach(k; SymbolTable.byKey) {
			count += SymbolTable[k].length;
		}
		return count / 2;
	}
	//Returns true if vertex is in graph
	bool exists(in T vertex) const {
		if (vertex in SymbolTable) //Not sure how to do this in one line :/
			return true;
		return false;
	}
	//Returns true if there is an edge from v to w
	bool exists(in T a, in T b) const {
		return exists(a) && ! find(SymbolTable[a].byKey(), b).empty;
	}
	//Returns the degree of given vertex (number of incident edges)
	ulong degree(in T v) {
		return exists(v) ? adjacentTo(v).length : 0;
	}
	//Returns an array of all vertices
	T[] getAllVertices() const {
		return SymbolTable.keys;
	}
	//Returns weight of edge between a and b
	ulong weightBetween(in T a, in T b) const {
		assert(exists(a, b));
		return SymbolTable[a][b];
	}
}

unittest {
	auto graph = new WeightedGraph!int(false);
	//Test addEdge()
	graph.addEdge(1, 2, 5);
	graph.addEdge(1, 3, 2);
	//Test adjacentTo()
	assert(graph.adjacentTo(1) == [2:5UL, 3:2UL]);
	assert(graph.adjacentTo(2) == [1:5UL]);
	assert(graph.adjacentTo(3) == [1:2UL]);
	assert(graph.adjacentTo(-1).length == 0);
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
	assert(graph.exists(1, 3));
	assert(!graph.exists(2, 3));
	assert(!graph.exists(-1, -2));
	//Test degree()
	assert(graph.degree(1) == 2);
	assert(graph.degree(2) == 1);
	//Test getAllVertices()
	assert(graph.getAllVertices() == [1, 2, 3]);
	//Test weightBetween()
	assert(graph.weightBetween(1, 2) == 5);
}
