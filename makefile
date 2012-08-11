# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -unittest -debug -gc -w -wi
RFLAGS = -inline -O -release

SRCDIR = .
OBJDIR = obj
BINDIR = bin
SOURCES = $(wildcard $(SRCDIR)/*.d)
OBJECTS = $(SOURCES:$(SRCDIR)/%.d=$(OBJDIR)/%.o)


all: $(OBJECTS)

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.d
	$(DC) $< $(DFLAGS) -od$(OBJDIR) -of$(BINDIR)/$*


release: DFLAGS = $(RFLAGS)
release: all


clean:
	rm -f $(SRCDIR)/*.o
	rm -f $(OBJDIR)/*.o
	rm -f $(BINDIR)/*
	cd graph; make clean
	cd "weighted graph"; make clean
