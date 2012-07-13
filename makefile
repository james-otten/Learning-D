# Makefile
# Copyright 2012 James Otten <james_otten@lavabit.com>

DC = dmd
DFLAGS = -inline -O -release
GDB = -unittest -debug -gc -w -wi

SRCDIR = .
OBJDIR = obj
BINDIR = bin
SOURCES = $(wildcard $(SRCDIR)/*.d)
OBJECTS = $(SOURCES:$(SRCDIR)/%.d=$(OBJDIR)/%.o)


$(BINDIR)/$(TARGET): $(OBJECTS)

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.d
	$(DC) $< $(DFLAGS) -od$(OBJDIR) -of$(BINDIR)/$*

debug: DFLAGS = $(GDB)
debug: $(BINDIR)/$(TARGET)


clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(BINDIR)/*
	cd graph; make clean
