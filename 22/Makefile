CXX ?= g++

.PHONY: all clean test %.test part1 part2 test_gamecopy test_noincfrec test_recurse

all: clean test part1 part2

part1:
	${CXX} game.cpp main.cpp -o part1

part2:
	${CXX} game.cpp recgame.cpp part2.cpp -o part2

clean:
	rm -f a.out part1 part2 test_gamecopy test_noinfrec test_recurse

all-tests := $(addsuffix .test, $(basename $(wildcard *.valid)))

test_gamecopy:
	${CXX} game.cpp test_gamecopy.cpp -o test_gamecopy

test_noinfrec:
	${CXX} game.cpp recgame.cpp test_noinfrec.cpp -o test_noinfrec

test_recurse:
	${CXX} game.cpp recgame.cpp test_recurse.cpp -o test_recurse

test: $(all-tests)
	@echo "All tests successful"

%.test: %.valid %
	@diff <(./$(word 2, $?)) $< || \
		(echo "test $< failed" && exit 1)
