# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -unittest -debug -gc -w -wi
RFLAGS = -inline -O -release

LIBOBJS = weightedGraph.o dijkstra.o
LIBSRC = weightedGraph.d dijkstra.d

TEST_TARGET = weightedGraphTest
TEST_SOURCE = weightedGraphTest.d

MPS_TARGET = minimumPathSum
MPS_SOURCE = minimumPathSum.d

all: $(LIBOBJS) $(TEST_TARGET) $(MPS_TARGET)

$(TEST_TARGET): $(OBJS) $(TEST_SOURCE)
	$(DC) $^ $(LIBOBJS) -of$@

$(MPS_TARGET): $(OBJS) $(MPS_SOURCE)
	$(DC) $^ $(LIBOBJS) -of$@

$(LIBOBJS): $(LIBSRC)
	$(DC) $^ $(DFLAGS) -c

release: DFLAGS = $(RFLAGS)
release: all


clean:
	rm -f *.o
	rm -f $(TEST_TARGET)
	rm -f $(MPS_TARGET)

