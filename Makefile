# This is a simple Makefile for a simple Fortan program.
# All the sources must have (!) unique names.

CC=gfortran
CFLAGS=
LDFLAGS=-fopenmp#-L/usr/lib -lblas
BINDIR=BIN

PROG=SNN
EXT=.O
#SRC=$(wildcard *.for *.f *.f90 *.f95 *.f03)
SRC=$(wildcard *.FOR *.F *.F90 *.F95 *.F03)
OBJ=$(addprefix $(BINDIR)/, $(addsuffix $(EXT), $(basename $(SRC))))
BIN=$(addprefix $(BINDIR)/, $(PROG))

all: $(BIN)

$(BINDIR)/%$(EXT): $(SRC) | $(BINDIR)
#	@echo $(SRC) ":" $(filter $(notdir $(basename, $@))%, $^)
	$(CC) -c $(CFLAGS) -o $@ $(filter $(notdir $(basename, $@))%, $^)

$(BIN): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(BINDIR):
	@mkdir -p $(BINDIR)

run: $(BIN)
	$(BIN)

.PHONY: clean

clean:
	rm -f $(BIN) $(OBJ)
