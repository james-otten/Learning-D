# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -inline -O -release
GDB = -unittest -debug -gc -w -wi

LIBOBJS = graph.o deque.o breadthFirstSearch.o
LIBSRC = graph.d deque.d breadthFirstSearch.d
TARGET = graphTest
SOURCE = graphTest.d

all: $(LIBOBJS) $(TARGET)

$(TARGET): $(OBJS)
	$(DC) $^ $(LIBOBJS) $(SOURCE) -of$@

$(LIBOBJS): $(LIBSRC)
	$(DC) $^ $(DFLAGS) -c

debug: DFLAGS = $(GDB)
debug: all


clean:
	rm -f *.o
	rm -f $(TARGET)
