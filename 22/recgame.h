#ifndef RECGAME_H
#define RECGAME_H
#include <vector>

#include "game.h"

class Recgame: public Game {
	public:
		Recgame();
		void play();
		bool isWon();
		Player winner();
		
	private:
		Player round(int player1card, int player2card);
		std::vector<std::pair<int, int>> played;
		int id;

		// isWon is true if this game ended early because the same stack
		// was played multiple times
		bool earlyWon = false;
		Player earlyWinner;
};

#endif
