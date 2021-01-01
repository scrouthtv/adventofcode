#include <stdlib.h>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <string>

#include "game.h"

using namespace std;

int main(int argc, char* argv[]) {
	ifstream infile("in1.txt");
	string line;

	Game g;
		
	bool player1 = true;

	while (getline(infile, line)) {
		if (line == "")
			continue;
		else if (line == "Player 1:")
			player1 = true;
		else if (line == "Player 2:")
			player1 = false;
		else {
			if (player1) g.add(PLAYER_ONE, stoi(line, nullptr));
			else g.add(PLAYER_TWO, stoi(line, nullptr));
		}
	}

	cout << to_string(&g);

	while (!g.isWon())
		g.play();

	cout << to_string(&g);
	cout << "Winner has " << g.score(g.winner()) << endl;
}
