/*
 * Translates console input to morse code.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;
import std.ascii;


string toMorse(in string str) {
	immutable string[dchar] morse = ['A':".-", 'B':"-...",'C':"-.-.",'D':"-..",'E':".",'F':"..-.",'G':"--.",'H':"....",'I':"..", 'J':".---",'K':"-.-",'L':".-..",'M':"--",'N':"-.", 'O':"---",'P':".--.",'Q':"--.-",'R':".-.",'S':"...",'T':"-",'U':"..-",'V':"...-",'W':".--",'X':"-..-",'Y':"-.--",'Z':"--..",'1':".----",'2':"..---",'3':"...--",'4':"....-",'5':".....",'6':"-....",'7':"--...",'8':"---..",'9':"----.",'0':"-----"];

	string ret;
	foreach(c; str) {
		if(isAlpha(c))
			ret ~= morse[toUpper(c)] ~ " ";
		else if(c == '-' || c == '.' ) ret ~= " ";
		else ret ~= c;
	}
	return ret;
}

void main() {
	foreach(line; stdin.byLine())
		writeln(toMorse(line.idup));
}
