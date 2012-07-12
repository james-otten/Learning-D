/*
 * Fun with Binary Trees and template classes
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.math;

class BinaryTree(T) {
	BinaryTreeNode!(T) root;
	int size;
	
	this() {}

	//#TODO Work out from the middle for a more balanced tree
	this(T[] list) {
		foreach(i; list)
			insert(i);
	}

	//Inserts a new node data into the tree
	void insert(T data) {
		void _insert(ref BinaryTreeNode!(T) croot, T data) {
			if(croot is null) {
				auto t = new BinaryTreeNode!(T)(data);
				croot = t;
				size++;
			}
			else {
				if(croot.data > data)
					_insert(croot.left, data);
				else if(croot.data < data)
					_insert(croot.right, data);
			}
		}
		_insert(root, data);
	}

	//Returns true if data is found in the tree	
	bool find(T data) {
		bool _find(ref BinaryTreeNode!(T) croot, T data) {
			if(croot is null) {
				return false;
			}
			else {
				if(croot.data == data)
					return true;
				else {
					if(croot.data > data)
						return _find(croot.left, data);
					else //(croot.data < data)
						return _find(croot.right, data);
				}
			}
		}
		return _find(root, data);
	}

	//Returns the lagest depth of a node from the root node
	int maxDepth() {
		int _maxDepth(ref BinaryTreeNode!(T) croot, int depth) {
			if(croot is null)
				return 0;
			else {
				int l = _maxDepth(croot.left, depth + 1);
				int r = _maxDepth(croot.right, depth + 1);
				return (l > r) ? l+1 : r+1;
			}
		}
		return _maxDepth(root, 0);
	}

	//Returns the smallest value on the tree (left most)
	T minValue() {
		T _minValue(ref BinaryTreeNode!(T) croot) {
			if(croot.left is null)
				return croot.data;
			else return _minValue(croot.left);
		}
		return _minValue(root);
	}

	//Returns the largest value on the tree (right most)
	T maxValue() {
		T _maxValue(ref BinaryTreeNode!(T) croot) {
			if(croot.right is null)
				return croot.data;
			else return _maxValue(croot.right);
		}
		return _maxValue(root);
	}

	//Returns a (sorted) array of the tree's elements
	T[] toArray() {
		T[] _toArray(ref BinaryTreeNode!(T) croot) {
			T[] ret = [];
			if(croot is null)
				return [];
			T[] l = _toArray(croot.left);
			T[] r = _toArray(croot.right);
			ret ~= l;
			ret ~= croot.data;
			ret ~= r;
			return ret;
		}
		return _toArray(root);
	}
}

//Node of a binary tree
class BinaryTreeNode(T) {
	T data;
	BinaryTreeNode left;
	BinaryTreeNode right;
	this(T d) { data = d; }
}

unittest {
	auto tree = new BinaryTree!(int)();
	tree.insert(2);
	tree.insert(1);
	tree.insert(3);
	tree.insert(-1);
	tree.insert(0);
	//Test size
	assert(tree.size == 5);
	//Test insert()
	assert(tree.root.data == 2);
	assert(tree.root.left.data == 1);
	assert(tree.root.right.data == 3);
	assert(tree.root.left.left.data == -1);
	assert(tree.root.left.left.right.data == 0);
	//Test find()
	assert(tree.find(2));
	assert(tree.find(1));
	assert(tree.find(3));
	assert(tree.find(-1));
	assert(tree.find(0));
	assert(!tree.find(100));
	//Test maxDepth()
	assert(tree.maxDepth() == 4);
	//Test minValue()
	assert(tree.minValue() == -1);
	//Test maxValue()
	assert(tree.maxValue() == 3);
	//Test toArray()
	assert(tree.toArray() == [-1, 0, 1, 2, 3]);
}

void main() {
	
}
