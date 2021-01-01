#include <iostream>

#include "game.h"

int main(int argc, char* argv[]) {
	Game g1;
	g1.add(PLAYER_ONE, 5);
	g1.add(PLAYER_ONE, 3);
	g1.add(PLAYER_ONE, 8);
	g1.add(PLAYER_TWO, 2);
	g1.add(PLAYER_TWO, 4);
	g1.add(PLAYER_TWO, 6);

	std::cout << to_string(&g1) << std::endl;

	std::cout << "Copy of g1" << std::endl;

	Game g2 = g1;

	std::cout << to_string(&g2) << std::endl;

	std::cout << "After one play on g1:" << std::endl;

	g1.play();
	std::cout << to_string(&g1) << std::endl;
	std::cout << to_string(&g2) << std::endl;
}
