import std.stdio;

//Template for the hyperoperator
T hyper(T)(in T n, in T a, in T b) {
	assert(n >= 0);
	
	if(n == 0)
		return b + 1;
	if(n == 1 && b == 0)
		return a;
	if(n == 2 && b == 0)
		return b;
	if(n >= 3 && b == 0)
		return 1;
	T t = hyper(n, a, b-1);
	return hyper(n-1, a, t);
}

unittest {
	assert(hyper(0, 2, 3) == 4);
	assert(hyper(1, 2, 3) == 5);
	assert(hyper(2, 2, 3) == 6);
	assert(hyper(3, 2, 3) == 8);
	assert(hyper(4, 2, 3) == 16);
}

void main() {
	writeln(hyper(1, 2, 3));
}
