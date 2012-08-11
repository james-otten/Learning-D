# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -unittest -debug -gc -w -wi
RFLAGS = -inline -O -release

LIBOBJS = graph.o deque.o breadthFirstSearch.o
LIBSRC = graph.d deque.d breadthFirstSearch.d
TARGET = graphTest
SOURCE = graphTest.d

all: $(LIBOBJS) $(TARGET)

$(TARGET): $(OBJS)
	$(DC) $^ $(LIBOBJS) $(SOURCE) -of$@

$(LIBOBJS): $(LIBSRC)
	$(DC) $^ $(DFLAGS) -c

release: DFLAGS = $(RFLAGS)
release: all


clean:
	rm -f *.o
	rm -f $(TARGET)
