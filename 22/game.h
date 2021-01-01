#ifndef game_h
#include <queue>
#define game_h

enum Player { PLAYER_ONE, PLAYER_TWO };

class Game {
	public:
		Game();
		void add(Player p, int card);
		void play();
		std::queue<int> *deck(Player p);
		bool isWon();
		Player winner();
		int score(Player p);

	private:
		std::queue<int> player1deck;
		std::queue<int> player2deck;
};

std::string to_string(Game* g);

#endif
