#ifndef GAME_H
#include <deque>
#include <string>
#define GAME_H

enum Player { PLAYER_ONE, PLAYER_TWO };

class Game {
	public:
		Game();
		Game(const Game &obj);
		void add(Player p, int card);
		void play();
		std::deque<int> *deck(Player p);
		bool isWon();
		Player winner();
		int score(Player p);

	private:
		std::deque<int> player1deck;
		std::deque<int> player2deck;
};

std::string to_string(Game* g);

#endif
