# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -inline -O -release
GDB = -unittest -debug -gc -w -wi

LIBOBJS = graph.o
TARGET = graph
SOURCE = graphTest.d

all: $(LIBOBJS) 
	$(DC) $(LIBOBJS) $(SOURCE) $(DFLAGS)

$(LIBOBJS): graph.d
	$(DC) $< $(DFLAGS) -c

debug: DFLAGS = $(GDB)
debug: all


clean:
	rm -f *.o
	rm -f $(TARGET)
