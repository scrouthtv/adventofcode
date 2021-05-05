#include <algorithm>
#include <string>

#include "recgame.h"

Recgame::Recgame() {

}

Player Recgame::round(int player1card, int player2card) {
	if (earlyWon) return earlyWinner;

	std::pair<int, int> cardpair = std::pair<int, int>(player1card, player2card);
	if (std::find(played.begin(), played.end(), cardpair) != played.end()) {
		earlyWon = true;
		earlyWinner = PLAYER_ONE;
		return PLAYER_ONE;
	}
	played.push_back(cardpair);

	if (deck(PLAYER_ONE)->size() > player1card
			|| deck(PLAYER_TWO)->size() > player2card)
		return player1card > player2card ? PLAYER_ONE : PLAYER_TWO;

	Recgame subgame = *this;
	while (!subgame.isWon()) {
		subgame.play();
	}

	return subgame.winner();
}

bool Recgame::isWon() {
	if (earlyWon) return true;
	return Game::isWon();
}

Player Recgame::winner() {
	if (earlyWon) return earlyWinner;
	return Game::winner();
}

void Recgame::play() {
	if (earlyWon) return; // Don't play if this game already ended

	int player1card = deck(PLAYER_ONE)->front();
	int player2card = deck(PLAYER_TWO)->front();
	deck(PLAYER_ONE)->pop_front();
	deck(PLAYER_TWO)->pop_front();
	Player winner = round(player1card, player2card);

	if (winner == PLAYER_ONE) {
		deck(PLAYER_ONE)->push_back(player1card);
		deck(PLAYER_ONE)->push_back(player2card);
	} else {
		deck(PLAYER_TWO)->push_back(player2card);
		deck(PLAYER_TWO)->push_back(player1card);
	}
}
