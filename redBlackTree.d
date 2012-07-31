/*
 * Red black tree class template
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

module redBlackTree;

import std.stdio;
import std.conv;
import std.random;

enum rbColor : bool{RED, BLACK};

class RedBlackTree(K, V) {
	 RedBlackTreeNode!(K, V) root;
	this() {}

	//Verify the properties of a red black tree
	private void verifyTree() const {
		//Helper for property 4
		void verify4(in RedBlackTreeNode!(K, V) node) {
			if(node !is null) {
				if(node.color == rbColor.RED) {
					assert(node.left is null || node.left.color == rbColor.BLACK, "Child of red node is black");
					assert(node.right is null ||node.right.color == rbColor.BLACK, "Child of red node is black");
					assert(node.parent is null ||node.parent.color == rbColor.BLACK, "Parent of red node is black");
				}
				verify4(node.left);
				verify4(node.right);
			}

		}
		//Helper for property 5
		void verify5(in RedBlackTreeNode!(K, V) node, int blacks, ref int pathBlacks) {			
			if(node !is null) {
				if(node.color == rbColor.BLACK)
					blacks++;}
			else {
				if(pathBlacks == -1)
					pathBlacks = blacks;
				else assert(blacks == pathBlacks);
				return;
			}
			verify5(node.left, blacks, pathBlacks);
			verify5(node.right, blacks, pathBlacks);
		}
		
		//1. A node is either red or black
		static assert(cast(bool)rbColor.max);
		//2. The root is black.
		assert(root is null || root.color == rbColor.BLACK, "Root is not black.");
		//3. All null leaves are black.
		//Don't need to check because null nodes are literally null
		//4. Both children of every red node are black.
		verify4(cast(RedBlackTreeNode!(K, V))root);
		//5. Every simple path from a given node to any of its descendant leaves contains the same number of black nodes.
		int pathBlacks = -1;
		verify5(cast(RedBlackTreeNode!(K, V))root, 0, pathBlacks);
	}

	//Get the first (smallest) element on the tree
	RedBlackTreeNode!(K, V) minimumNode() const {
		return minimumNode(root);
	}

	//Get the first (smallest) element on the tree
	RedBlackTreeNode!(K, V) minimumNode(in RedBlackTreeNode!(K, V) node) const {
		assert(node !is null, "First element of empty tree");
		auto n = cast(RedBlackTreeNode!(K, V))node;
		while(n.right !is null)
			n = n.left;
		return n;
	}

	//Get the largest element on the tree
	RedBlackTreeNode!(K, V) maximumNode() const {
		return maximumNode(root);
	}

	//Farthest right node from node
	RedBlackTreeNode!(K, V) maximumNode(in RedBlackTreeNode!(K, V) node) const {
		assert(node !is null, "Last element of empty tree");
		auto n = cast(RedBlackTreeNode!(K, V))node;
		while(n.right !is null)
			n = n.right;
		return n;
	}
	
	private void insertCase1(RedBlackTreeNode!(K, V) node) {
		if(node.parent is null)
			node.color = rbColor.BLACK;
		else insertCase2(node);
	}
	private void insertCase2(RedBlackTreeNode!(K, V) node) {
		if(node.parent.color == rbColor.RED)
			insertCase3(node);
	}
	private void insertCase3(RedBlackTreeNode!(K, V) node) {
		auto u = uncle(node);
		if(u !is null && u.color == rbColor.RED) {
			auto g = grandparent(node);
			node.parent.color = rbColor.BLACK;
			u.color = rbColor.BLACK;
			g.color = rbColor.RED;
			insertCase1(g);
		}
		else insertCase4(node);
	}
	private void insertCase4(RedBlackTreeNode!(K, V) node) {
		auto g = grandparent(node);
		if(node is node.parent.right && node.parent is g.left) {
			rotateLeft(node.parent);
			node = node.left;
		}
		else if(node is node.parent.left && node.parent is g.right) {
			rotateRight(node.parent);
			node = node.right;
		}
		insertCase5(node);
	}
	private void insertCase5(RedBlackTreeNode!(K, V) node) {
		auto g = grandparent(node);
		node.parent.color = rbColor.BLACK;
		g.color = rbColor.RED;
		if(node == node.parent.left)
			rotateRight(g);
		else rotateLeft(g);
	}

	//Insert K:V into the tree
	void insert(in K newKey, in V newValue) {
		auto newNode = new RedBlackTreeNode!(K, V)(newKey, newValue, rbColor.RED);
		if(root is null)
			root = newNode;
		else {
			auto node = root;
			while(true) {
				if(newKey == node.key) {
					node.value = newValue;
					return;
				}
				else if(newKey < node.key) {
					if(node.left is null) {
						node.left = newNode;
						break;
					}
					else node = node.left;
				}
				else {
					if(node.right is null) {
						node.right = newNode;
						break;
					}
					else node = node.right;
				}
			}
			newNode.parent = node;
		}
		insertCase1(newNode);
		verifyTree();
	}

	private void removeCase1(RedBlackTreeNode!(K, V) node) {
		if(node.parent is null)
			return;
		else removeCase2(node);
	}

	private void removeCase2(RedBlackTreeNode!(K, V) node) {
		auto siblingNode = sibling(node);
		if(siblingNode.color == rbColor.RED) {
			node.parent.color = rbColor.RED;
			siblingNode.color = rbColor.BLACK;
			if(node == node.parent.left)
				rotateLeft(node.parent);
			else rotateRight(node.parent);
		}
		removeCase3(node);
	}

	private void removeCase3(RedBlackTreeNode!(K, V) node) {
		auto siblingNode = sibling(node);
		if(node.parent.color == rbColor.BLACK && siblingNode.color == rbColor.BLACK &&
			siblingNode.left.color == rbColor.BLACK && siblingNode.right.color == rbColor.BLACK) {
			siblingNode.color = rbColor.RED;
			removeCase1(node.parent);
		}
		else removeCase4(node);
	}

	private void removeCase4(RedBlackTreeNode!(K, V) node) {
		auto siblingNode = sibling(node);
		if(node.parent.color == rbColor.RED && siblingNode.color == rbColor.BLACK &&
			siblingNode.left.color == rbColor.BLACK && siblingNode.right.color == rbColor.BLACK) {
			siblingNode.color = rbColor.RED;
			node.parent.color = rbColor.BLACK;
		}
		else removeCase5(node);
	}

	private void removeCase5(RedBlackTreeNode!(K, V) node) {
		auto siblingNode = sibling(node);
		if(node == node.parent.left && siblingNode.color == rbColor.BLACK &&
			siblingNode.left.color == rbColor.RED && siblingNode.right.color == rbColor.BLACK) {
			siblingNode.color = rbColor.RED;
			siblingNode.left.color = rbColor.BLACK;
			rotateRight(siblingNode);
		}
		else if(node == node.parent.right && siblingNode.color == rbColor.BLACK &&
			siblingNode.right.color == rbColor.RED && siblingNode.left.color == rbColor.BLACK) {
			siblingNode.color = rbColor.RED;
			siblingNode.right.color = rbColor.BLACK;
			rotateLeft(siblingNode);
		}
		removeCase6(node);
	}

	private void removeCase6(RedBlackTreeNode!(K, V) node) {
		auto siblingNode = sibling(node);
		siblingNode.color = node.parent.color;
		node.parent.color = rbColor.BLACK;
		if(node == node.parent.left) {
			assert(siblingNode.right.color == rbColor.RED);
			siblingNode.right.color = rbColor.BLACK;
			rotateLeft(node.parent);
		}
		else {
			assert(siblingNode.left.color == rbColor.RED);
			siblingNode.left.color = rbColor.BLACK;
			rotateRight(node.parent);
		}
	}

	//Remove value from the tree
	//TODO: Segfault
	void remove(in K key) {
		auto node = search(key);
		if(node !is null) {
			auto child = (node.right is null) ? node.left : node.right;
			replaceNode(child, node);
			if(node.color == rbColor.BLACK) {
				if(child.color == rbColor.RED)
					child.color = rbColor.BLACK;
				else removeCase1(child);
			}
		}
	}

	//Search the tree for value
	RedBlackTreeNode!(K, V) search(in K searchKey) const {
		auto ret = cast(typeof(return))root;
		while(ret !is null) {
			if(ret.key > searchKey)
				ret = ret.left;
			else if(ret.key < searchKey)
				ret = ret.right;
			else return ret;
		}
		return null;
	}

	//Rotate node left
	private void rotateLeft(RedBlackTreeNode!(K, V) node) {
		auto rightNode = node.right;
		replaceNode(node, rightNode);
		node.right = rightNode.left;
		if(rightNode.left !is null)
			rightNode.left.parent = node;
		rightNode.left = node;
		node.parent = rightNode;
	}
	
	//Rotate the node left
	private void rotateRight(RedBlackTreeNode!(K, V) node) {
		auto leftNode = node.left;
		replaceNode(node, leftNode);
		node.left = leftNode.right;
		if(leftNode.right !is null)
			leftNode.right.parent = node;
		leftNode.right = node;
		node.parent = leftNode;
	}
	
	//Replace oldNode with newNode
	private void replaceNode(RedBlackTreeNode!(K, V) oldNode, RedBlackTreeNode!(K, V) newNode) {
		if(oldNode.parent is null)
			root = newNode;
		else {
			if(oldNode == oldNode.parent.left)
				oldNode.parent.left = newNode;
			else oldNode.parent.right = newNode;
		}
		if(newNode !is null)
			newNode.parent = oldNode.parent;
	}

	//Returns the other child of node's parent
	private RedBlackTreeNode!(K, V) sibling(RedBlackTreeNode!(K, V) node) const {
		assert(node !is null, "Sibling of a null node.");
		assert(node.parent !is null, "Root has no sibling");
		if(node == node.parent.left)
			return node.parent.right;
		return node.parent.left;
	}

	//Returns the grandparent of the given node
	private RedBlackTreeNode!(K, V) grandparent(RedBlackTreeNode!(K, V) node) const {
		if(node !is null && node.parent !is null)
			return node.parent.parent;
		else return null;
	}

	//Returns the uncle of the given node
	private RedBlackTreeNode!(K, V) uncle(RedBlackTreeNode!(K, V) node) const {
		auto g = grandparent(node);
		if(g is null)
			return null;
		if(node.parent == g.left)
			return g.right;
		return g.left;
	}

	//Returns the lagest depth of a node from the root node
	//TODO: const
	int maxDepth() {
		int _maxDepth(RedBlackTreeNode!(K, V) croot, int depth) {
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

	//Returns a (sorted) array of the tree's element's keys
	//TODO: const
	K[] keys() {
		K[] _toArray(RedBlackTreeNode!(K, V) croot) {
			K[] ret = [];
			if(croot is null)
				return [];
			K[] l = _toArray(croot.left);
			K[] r = _toArray(croot.right);
			ret ~= l;
			ret ~= croot.key;
			ret ~= r;
			return ret;
		}
		return _toArray(root);
	}

	//Returns a (sorted) array of the tree's element's values
	//TODO: const
	V[] values() {
		V[] _toArray(RedBlackTreeNode!(K, V) croot) {
			V[] ret = [];
			if(croot is null)
				return [];
			V[] l = _toArray(croot.left);
			V[] r = _toArray(croot.right);
			ret ~= l;
			ret ~= croot.value;
			ret ~= r;
			return ret;
		}
		return _toArray(root);
	}
}

class RedBlackTreeNode(K, V) {
	private K key;
	V value;
	rbColor color;
	RedBlackTreeNode!(K, V) left;
	RedBlackTreeNode!(K, V) right;
	RedBlackTreeNode!(K, V) parent;
	this(K Key, V Value) { key = Key; value = Value;  }
	this(K Key, V Value, rbColor Color) { key = Key; value = Value; color = Color; }
	this(K Key, V Value, rbColor Color, typeof(this) Left, typeof(this) Right) {
		key = Key;
		value = Value;
		color = Color;
		left = Left;
		right = Right;
		if(left !is null) left.parent = this;
		if(right !is null) right.parent = this;
	}
}


unittest {

}

void main() {
	immutable max = 1000;
	immutable numElements = 100;
	auto rbtree = new RedBlackTree!(int, int);
	for(int i = 0; i < numElements; i++) {
		int k = i;
		int v = uniform(0, max);
		rbtree.insert(k, v);
		auto n = rbtree.search(k);
		assert(n !is null, "New key not found.");
		assert(n.value == v, "Key is pointing to the wrong value.");
	}
	writeln("start" ~ rbtree.toString() ~ "\n\n");
	writeln("max depth: ", rbtree.maxDepth());
	writeln(rbtree.keys().length);
	//writeln(rbtree.values());
	/*for(int i = 0; i < numElements; i++) {
		int k = i;//uniform(0, max);
		rbtree.remove(k);
	}
	writeln(rbtree.keys().length);*/
}
