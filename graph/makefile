# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = ldmd2
DFLAGS = -unittest -debug -gc -w -wi
LDFLAGS = -debug -g -w -wi
RFLAGS = -inline -O -release -w -wi

LIBRARY = graph.a
LIBSRC = graph.d deque.d breadthFirstSearch.d
TARGET = graphTest
SOURCE = graphTest.d

all: $(LIBRARY) $(TARGET)

$(TARGET): $(LIBRARY) $(SOURCE) 
	$(DC) $(SOURCE) $(LIBRARY) $(DFLAGS) -of$@

$(LIBRARY) : $(LIBSRC)
	$(DC) -lib $(LIBSRC) $(LDFLAGS) -of$@

release: DFLAGS = $(RFLAGS)
release: all


clean:
	rm -f *.o
	rm -f $(TARGET)
	rm -f $(LIBRARY)
