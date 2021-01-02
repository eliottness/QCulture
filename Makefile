#####################################################################
############################### MAIN ################################
#####################################################################

CC = gccgo
CFLAGS = -Wall -Wextra -Werror
LDFLAGS = #TODO
LD_LIBS = #TODO

TEST_SRC = $(wildcard qculture/*_test.go)

SRC = $(filter-out $(TEST_SRC),$(wildcard qculture/*.go))
OBJ = $(SRC:.go=.o)
BIN = web.out

#####################################################################
############################### RULES ###############################
#####################################################################

### Main Rules ###

all: build

.PHONY: clean build all run compile test

### GCCGO compiling ###

# Rule to compile your exo with a custom main function
compile: $(OBJ)
	$(CC) -o $(BIN) $^ $(LDFLAGS) $(LDLIBS)

%.o: %.go
	$(CC) $(CFLAGS) $^ -c -o $@

### Run Rules ###

build: $(SRC)
	go build -o $(BIN) $(SRC)

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

run: $(SRC)
	go run $(SRC) $(RUN_ARGS)

### Testing ###

test: $(SRC) $(TEST_SRC)
	go test -v $(SRC) $(TEST_SRC)

### Aux ###

fmt:
	@go fmt qculture/*

clean:
	$(RM) $(OBJ)
	$(RM) $(LIB)
	$(RM) $(BIN)
	go clean

