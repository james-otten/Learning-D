/*
 * Find the greatest product of N consecutive digits of the user's number
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.conv;

//Returns the product of all the numbers in arr
int product(int[] arr) {
	int ret = 1;
	foreach(v; arr)
		ret *= v;
	return ret;
}

//Find the greatest product of N consecutive digits of num
int greatestProduct(in string num, in int N) {
	assert(N > 0);
	assert(num.length >= N);

	int[] set;
	auto toInt = (char d) {return to!int(d) - 48;};
	for(int i = 0; i < N; i++) //Fill set with the first
		set ~= toInt(num[i]); //Because we remove an element in our loop
	int maxIndex = 0;
	int maxProduct = product(set);
	int tempProduct;
	for(int i = N + 1; i < num.length; i++) {
		set = set[1..$];
		set ~= toInt(num[i]);
		tempProduct = product(set);
		if(tempProduct > maxProduct) {
			maxProduct = tempProduct;
			maxIndex = i;
		}
	}
	return maxProduct;
}

unittest {
	assert(product([1, 2, 3]) == 6);
	assert(greatestProduct("91234111", 5) == 216);
	assert(greatestProduct("9123411199", 5) == 324);
	//Problem 8
	immutable string num = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
	assert(greatestProduct(num, 5) == 40824);
}

void main() {
	int n;
	char[] num;

	writeln("Enter a number to find the greatest product of N sequential digits:");
	readln(num);
	writeln("Enter N:");
	readf(" %d", &n);
	writefln("The maximum consecutive product is: %d", greatestProduct(num[0..$-1].idup, n)); //Remove newline that readln read
}
