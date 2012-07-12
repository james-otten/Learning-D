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
	ulong a, b, n;
	writeln("hyperoperator(n, a, b)");
	writeln("Enter n:");
	stdin.readf(" %d", &n);
	writeln("Enter a:");
	stdin.readf(" %d", &a);
	writeln("Enter b:");
	stdin.readf(" %d", &b);
	writefln("hyperoperator(%d, %d, %d) = %d", n, a, b, hyper(n, a, b));
}
