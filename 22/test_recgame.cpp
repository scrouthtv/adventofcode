#include <stdlib.h>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <string>

#include "recgame.h"

using namespace std;

// Test whether we recurse correctly.

int main(int argc, char* argv[]) {
	Recgame g;
		
	g.add(PLAYER_ONE, 9);
	g.add(PLAYER_ONE, 2);
	g.add(PLAYER_ONE, 6);
	g.add(PLAYER_ONE, 3);
	g.add(PLAYER_ONE, 1);
	g.add(PLAYER_TWO, 5);
	g.add(PLAYER_TWO, 8);
	g.add(PLAYER_TWO, 4);
	g.add(PLAYER_TWO, 7);
	g.add(PLAYER_TWO, 10);
	cout << to_string(&g);

	while (!g.isWon()) {
		g.play();
		cout << to_string(&g);
	}

	cout << "Player " << (g.winner() == PLAYER_ONE ? "1" : "2") << " won the game!" << endl;
	cout << "Winner has " << g.score(g.winner()) << endl;
	g.play();

}
