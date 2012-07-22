/*
 * Strips C style comments from stdin
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

string stripComments(in string input) {
	string ret;
	for(int i = 0; i < input.length; i++) {
		//Add the string literal
		if(input[i] == '\"') {
			ret ~= input[i];
			while(i+1 < input.length && input[i+1] != '\"') {
				if(input[i+1] == '\\') { //Escape sequence
					ret ~= '\\';
					ret ~= input[i+2];
					i += 2;
				}
				else {
					ret ~= input[i+1];
					i++;
				}
			}
			i++;
			ret ~= input[i];
		}
		else if(input[i] == '/') {
			//Pass the line comment
			if(i+1 < input.length && input[i+1] == '/') {
				while(i < input.length && input[i] != '\n') {i++;};
			}
			//Pass the block comment
			else if(i+1 < input.length && input[i+1] == '*') {
				i += 2;
				while(i < input.length && input[i+1] != '*' && input[i+2] != '/') {i++;}
				i += 2;
			}		
			else ret ~= input[i];
		}
		else {
			ret ~= input[i];
		}
	}
	return ret;
}

unittest {
	assert(stripComments("int /* comment */ foo() { }") == "int  foo() { }");
	assert(stripComments("void /*blahblahblah*/bar() { for(;;) } // line comment") == "void bar() { for(;;) } ");
	assert(stripComments("  { /*here*/ \"but\", \"/*not here*/ \\\" /*or here*/\" } // strings") == 
			     "  {  \"but\", \"/*not here*/ \\\" /*or here*/\" } ");
}

void main() {
	foreach(line; stdin.byLine())
		writeln(stripComments(line.idup));
}
