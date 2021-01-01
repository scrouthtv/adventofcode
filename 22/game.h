#ifndef game_h
#include <deque>
#define game_h

enum Player { PLAYER_ONE, PLAYER_TWO };

class Game {
	public:
		Game();
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
