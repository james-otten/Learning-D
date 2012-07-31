#Learning-D
Code written while learning D.

####Programs:
* crop.d - Finds the smallest cropped sub-matrix that contains all the 1s from a larger matrix.
* zeckendorfRepresentation.d - Finds the Zeckendorf Representation of a given number. [Wikipedia](https://en.wikipedia.org/wiki/Zeckendorf_representation)
* higherOrderFibonacci.d - Higher order fibonacci numbers. [Wikipedia](https://en.wikipedia.org/wiki/Generalizations_of_Fibonacci_numbers#Fibonacci_numbers_of_higher_order)
* hyperoperator.d - Recursive implementation of the hyperoperator [Wikipedia](https://en.wikipedia.org/wiki/Hyperoperation)
* missing.d - Which number from a range is missing?
* binaryTrees.d - Fun with binary trees and class templates.
* graph/
    - graph.d - Undirected, adjacency list, graph class template.
    - deque.d - Simple deque using a dynamic array.
    - breadthFirstSearch.d - Breadth First Search for my graph type (graph/graph.d) [Wikipedia](https://en.wikipedia.org/wiki/Breadth_first_search)
    - graphTest.d - Small test program that uses graph.d, deque.d, breadthFirstSearch.d.
* permutation.d - Iteratively generates permutations of a given array like C++'s STL next_permutation().
* morseCode.d - Translates console input to Morse code.
* sumOfPrimes.d - Calculates the sum of primes below a given number, uses the sieve of Eratosthenes.
* pythagoreanTriplet.d - Finds Pythagorean triplets with a user defined sum.
* greatestProduct.d - Find the greatest product of N consecutive digits of the user's number.
* comments.d - Removes C style comments from stdin.
* weighted graph/
    - dijkstra.d - Dijkstra's algorithm with my weighted graph type (weighted graph/weightedGraph.d) [Wikipedia](https://en.wikipedia.org/wiki/Dijkstra's_algorithm)
    - weightedGraph.d - Undirected or directed, adjacency list, weighted graph class template.
    - weightedGraphTest.d - Small test program that uses dijkstra.d and weightedGraph.d
* redBlackTree.d - Red black tree class template.

####Building:
Debug: `make debug`
    
Release: `make`
