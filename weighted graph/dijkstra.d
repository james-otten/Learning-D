/*
 * Dijkstra's algorithm with my weighted graph type
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/
module dijkstra;

import std.stdio;
import std.algorithm;
import std.array;
import weightedGraph;

class Dijkstra(T) {
	private immutable inf = ulong.max; //We'll say infinity is ulong.max
	private ulong[T] distance;
	private T[T] prev;
	private T me;

	this() {}

	this(WeightedGraph!T graph, T startVertex) {
		me = startVertex;
		foreach(v; graph.getAllVertices()) {
			distance[v] = inf;
		}
		distance[startVertex] = 0;
		
		auto q = graph.getAllVertices();
		while(q.length != 0) {
			//Find u, the vertex in q with the smallest distance[]
			T u = q[0];
			foreach(v; q) {
				if(distance[v] < distance[u])
					u = v;
			}
			if(distance[u] == inf)
				break; //Everything else cannot be reached from startVertex
			//Remove u from q
			remove(q, u);
			
			foreach(k, v; graph.adjacentTo(u)) {
				ulong alt = distance[u] + graph.weightBetween(u, k);
				if(alt < distance[k]) {
					distance[k] = alt;
					prev[k] = u;
				}
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

	//Helper function, removes element from arr once
	private static void remove(ref T[] arr, T element) {
		foreach(i, v; arr)
			if(v == element) {
				if(i == 0)
					arr = arr[1..$];
				else if(i == arr.length-1)
					arr = arr[0..$-1];
				else arr = arr[0..i] ~ arr[i+1..$];
				return; //Should only be one in this case
			}
	}
}

unittest {
	auto graph = new WeightedGraph!int;
	
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

	auto d = new Dijkstra!int(graph, 1);
	
	assert(d.distanceTo(1) == 0);
	assert(d.distanceTo(2) == 7);
	assert(d.distanceTo(3) == 9);
	assert(d.distanceTo(4) == 20);
	assert(d.distanceTo(5) == 20);
	assert(d.distanceTo(6) == 11);

	assert(d.pathTo(1).empty);
	assert(d.pathTo(2) == [2]);
	assert(d.pathTo(3) == [3]);
	assert(d.pathTo(4) == [3, 4]);
	assert(d.pathTo(5) == [3, 6, 5]);
	assert(d.pathTo(6) == [3, 6]);

	for(int i = 1; i <= 6; i++)
		assert(d.isReachable(i));
	assert(!d.isReachable(0));
	
	int[] arr = [1, 2, 3, 4, 5];
	d.remove(arr, 2);
	assert(arr == [1, 3, 4, 5]);
	d.remove(arr, 1);
	assert(arr == [3, 4, 5]);
	d.remove(arr, 5);
	assert(arr == [3, 4]);
	d.remove(arr, 4);
	assert(arr == [3]);
}
