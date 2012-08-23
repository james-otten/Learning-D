# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = ldmd2
DFLAGS = -unittest -debug -g -w -wi
LDFLAGS = -debug -g -w -wi
RFLAGS = -inline -O -release -w -wi

LIBRARY = weightedGraph.a
LIBSRC = weightedGraph.d dijkstra.d

TEST_TARGET = weightedGraphTest
TEST_SOURCE = weightedGraphTest.d

MPS_TARGET = minimumPathSum
MPS_SOURCE = minimumPathSum.d

all: $(LIBRARY) $(TEST_TARGET) $(MPS_TARGET)

$(TEST_TARGET): $(LIBRARY) $(TEST_SOURCE)
	$(DC) $(TEST_SOURCE) $(LIBRARY) $(DFLAGS) -of$@

$(MPS_TARGET): $(LIBRARY) $(MPS_SOURCE)
	$(DC) $(MPS_SOURCE) $(LIBRARY) $(DFLAGS) -of$@

$(LIBRARY) : $(LIBSRC)
	$(DC) -lib $(LIBSRC) $(DLFLAGS) -of$@

release: DFLAGS = $(RFLAGS)
release: all


clean:
	rm -f *.o
	rm -f $(TEST_TARGET)
	rm -f $(MPS_TARGET)
	rm -f $(LIBRARY)

