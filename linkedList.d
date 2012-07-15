/*
 * Simple linked list as template class
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

class LinkedList(T) {
	LinkedListNode!(T) head;
	
	this() {}

	//Inserts a new node into the back of a linked list
	void insert(T data) {
		auto item = new LinkedListNode!(T)(data);
		if(head is null) { head = item; }
		else {
			auto pos = head;
			while(pos.next !is null)
				pos = pos.next;
			pos.next = item;
		}
	}

	//Inserts a new node data into the linked list, in position n
	void insert(T data, ulong n) {
		auto item = new LinkedListNode!(T)(data);
		if(head is null) { head = item;}
		auto pos = head;
		for(int i = 0; i < n - 1; i++) {
			pos = pos.next;
		}
		item.next = pos.next;
		pos.next = item;
	}

	//void remove(ulong index) {
	//	assert(index > 0, "Index cannot be negative.");	
	//}

	//Returns pointer to list element, null if not found.
	bool find(T data) {
		auto pos = head;
		while(pos !is null) {
			if(pos.data == data)
				return true;
			pos = pos.next;
		}
		return false;
		
	}

	//Returns an array of the linked list's elements
	T[] toArray() {
		T[] ret = [];
		auto pos = head;
		while(pos !is null) {
			ret ~= pos.data;
			pos = pos.next;
		}
		return ret;
	}
}

//Node of a linked list
class LinkedListNode(T) {
	T data;
	LinkedListNode!(T) next;
	this(T d) { data = d; next = null; };
}

unittest {
}

void main() {
	auto l = new LinkedList!(int)();
	l.insert(1);
	l.insert(2);
	writeln(l.toArray());
}
