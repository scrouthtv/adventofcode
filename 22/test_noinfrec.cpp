#include <stdlib.h>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <string>

#include "recgame.h"

using namespace std;

// Test whether infinite games of recursive combat are
// prevented.

int main(int argc, char* argv[]) {
	Recgame g;
		
	g.add(PLAYER_ONE, 43);
	g.add(PLAYER_ONE, 19);
	g.add(PLAYER_TWO, 2);
	g.add(PLAYER_TWO, 29);
	g.add(PLAYER_TWO, 14);
	cout << to_string(&g);

	g.play();

	while (!g.isWon()) {
		g.play();
		cout << to_string(&g);
	}

	g.play();

	cout << "Player " << (g.winner() == PLAYER_ONE ? "1" : "2") << " won the game!" << endl;
	cout << "Winner has " << g.score(g.winner()) << endl;
	g.play();

}
