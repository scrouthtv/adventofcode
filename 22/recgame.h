#ifndef RECGAME_H
#define RECGAME_H
#include <vector>

#include "game.h"

class Recgame: public Game {
	public:
		Recgame(const Recgame &obj);
		void play();
		
	private:
		Player round(int player1card, int player2card);
		std::vector<std::pair<int, int>> played;
};

#endif
