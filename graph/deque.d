/*
 * A simple Deque as class template.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.algorithm;

class Deque(T) {
	T[] data;
	this()() {}

	//Number of elements in deque
	ulong length() {
		return data.length;
	}
	
	//Returns true if the deque is empty
	bool empty() {
		return data.length == 0;
	}

	//Insert element at front
	void pushFront(T x) {
		data = x ~ data;
	}
	//Insert element at back
	void pushBack(T x) {
		data ~= x;
	}
	//Remove first element
	T popFront() {
		assert(data.length, "Can't popFront() an empty deque.");
		T ret = data[0];
		data = data[1..$];
		return ret;
	}
	//Remove last element
	T popBack() {
		assert(data.length, "Can't popBack() an empty deque.");
		T ret = data[$-1];
		data = data[0..$-1];
		return ret;
		
	}
	//Return first element
	T front() {
		assert(data.length, "Can't front() an empty deque.");
		return data[0];
	}
	//Return last element
	T back() {
		assert(data.length, "Can't back() an empty deque.");
		return data[$-1];
	}
}

unittest {
	auto q = new Deque!(int)();
	q.pushFront(2);
	q.pushFront(1);
	q.pushBack(3);
	assert(q.front() == 1);
	assert(q.back() == 3);
	assert(q.length() == 3);
	assert(q.popFront() == 1); assert(q.length() == 2);
	assert(q.popBack() == 3); assert(q.length() == 1);
}
