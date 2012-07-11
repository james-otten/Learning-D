/*
 * Finds the smallest cropped sub-matrix that contains all the 1s from a larger matrix.
 * Copyright 2012 James Otten <james_otten@lavabit.com>
*/

import std.stdio;

immutable HEIGHT = 11;
immutable LENGTH = 16;

int input[HEIGHT][LENGTH] =     [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                                [0,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0],
                                [0,0,0,0,0,0,1,1,1,1,0,1,0,0,0,0],
                                [0,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0],
                                [0,0,0,0,0,1,1,0,1,1,1,0,0,0,0,0],
                                [0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
                                [0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0],
                                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                                [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];

void main() {
	int hmin = LENGTH - 1, hmax = 0, vmin = HEIGHT - 1, vmax = 0;
	for(int i = 0; i < HEIGHT; i++) {
		for(int j = 0; j < LENGTH; j++) {
			if(input[i][j] == 1) {
				if(i < hmin) hmin = i;
				else if(i > hmax) hmax = i;
				if(j < vmin) vmin = j;
				else if(j > vmax) vmax = j;
			}
		}
	}

	for(int i = hmin; i <= hmax; i++) {
		for(int j = vmin; j <= vmax; j++)
			write(input[i][j]);
		writeln();
	}
}
