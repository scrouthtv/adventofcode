#include <algorithm>
#include <string>

#include "recgame.h"

Player Recgame::round(int player1card, int player2card) {
	std::pair<int, int> cardpair = std::pair<int, int>(player1card, player2card);
	if (std::find(played.begin(), played.end(), cardpair) != played.end()) {
		return PLAYER_ONE;
	}
	played.push_back(cardpair);

	if (deck(PLAYER_ONE)->size() > player1card
			|| deck(PLAYER_TWO)->size() > player2card)
		return player1card > player2card ? PLAYER_ONE : PLAYER_TWO;

	Recgame subgame(this);
}

void Recgame::play() {
	int player1card = deck(PLAYER_ONE)->front();
	int player2card = deck(PLAYER_TWO)->front();
	deck(PLAYER_ONE)->pop_front();
	deck(PLAYER_TWO)->pop_front();
	round(player1card, player2card);
}
