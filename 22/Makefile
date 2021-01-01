CPP=g++
SHELL=/bin/sh

part1:
	${CPP} game.cpp main.cpp -o part1

part2:
	${CPP} game.cpp recgame.cpp part2.cpp -o part2

clean:
	rm -f a.out part1 part2 test1

test:
	${CPP} game.cpp test_gamecopy.cpp -o test1
	diff <(./test1) test11.valid > /dev/null || \
		(echo "test11.valid failed" && exit 1)
	part1
	diff <(./part1) part11.valid > /dev/null || \
		(echo "part11.valid failed" && exit 1)
	@echo "Success, all tests passed."
