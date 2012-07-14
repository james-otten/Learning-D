/*
 * Breadth First Search
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.algorithm;
import std.array;
import graph;
import deque;

class BreadthFirstSearch(T) {
	ulong[T] distance;
	T me;
	T[T] prev;
	this(Graph!(T) graph, T vertex) {
		auto q = new Deque!(T)();
		me = vertex;
		q.pushFront(me);
		distance[me] = 0;
		while(!q.empty()) {
			T v = q.popFront();
			T[] adj = graph.adjacentTo(v);
			foreach(k; adj)
				if(k !in distance) { //If we don't have the key yet (haven't come to this vertex yet) 
					q.pushFront(k);
					distance[k] = distance[v] + 1;
					prev[k] = v;
				}
		}
	}
	
	//Distance from our element to v
	ulong distanceTo(T v) {
		return distance[v];
	}
	//Path from our element to v
	T[] pathTo(T k) {
		T[] ret;
		while(k in distance && k != me) {//Key exists
			ret.insertInPlace(0, k);
			k = prev[k];
		}
		return ret;
	}
	
	//If v is reachable from our element
	bool isReachable(T v) {
		return !find(distance.byKey, v).empty; //Key exists
	}
}

unittest {
	auto graph = new Graph!(int)();
	graph.addEdge(1, 2);
	graph.addEdge(2, 3);
	graph.addEdge(2, 4);
	graph.addEdge(4, 5);
	graph.addEdge(2, 5);

	auto bfs = new BreadthFirstSearch!(int)(graph, 1);
	assert(bfs.distanceTo(1) == 0);
	assert(bfs.distanceTo(2) == 1);
	assert(bfs.distanceTo(5) == 2);
	
	assert(bfs.pathTo(1) == []);
	assert(bfs.pathTo(5) == [2, 5]);
	
	assert(bfs.isReachable(5));
	assert(!bfs.isReachable(-1));
}
