#include <algorithm>
#include <string>
#include <iostream>

#include "recgame.h"

int gameCounter = 0;

Recgame::Recgame() {
	id = gameCounter++;
}

Player Recgame::round(int player1card, int player2card) {

	// check if this exact set was played already:
	std::pair<int, int> cardpair = std::pair<int, int>(player1card, player2card);
	if (std::find(played.begin(), played.end(), cardpair) != played.end()) {
		std::cout << id << ": Ending the game early because this combination was already played. Player 1 wins" << std::endl;
		earlyWon = true;
		earlyWinner = PLAYER_ONE;
		return PLAYER_ONE;
	}
	played.push_back(cardpair);

	// If at least one player doesn't have as many cards as their card value,
	// the player with the higher-valued card wins:
	if (deck(PLAYER_ONE)->size() < player1card
			|| deck(PLAYER_TWO)->size() < player2card)
		return player1card > player2card ? PLAYER_ONE : PLAYER_TWO;


	// Recurse into a new game:
	std::cout << "Recursing into a subgame:" << std::endl;
	Recgame subgame;

	auto it = deck(PLAYER_ONE)->begin();
	for (int i = 0; i < player1card; i++) {
		subgame.add(PLAYER_ONE, *it);
		++it;
	}

	it = deck(PLAYER_TWO)->begin();
	for (int i = 0; i < player2card; i++) {
		subgame.add(PLAYER_TWO, *it);
		++it;
	}

	std::cout << to_string(&subgame);

	while (!subgame.isWon()) subgame.play();

	std::cout << "Player " << (subgame.winner() == PLAYER_ONE ? "1" : "2") << " won:" << std::endl;
	std::cout << to_string(&subgame);

	std::cout << "Returning to the outer game." << std::endl;

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

	// Each player plays their card first:
	int player1card = deck(PLAYER_ONE)->front();
	int player2card = deck(PLAYER_TWO)->front();
	deck(PLAYER_ONE)->pop_front();
	deck(PLAYER_TWO)->pop_front();

	// Determine the winner:
	Player winner = round(player1card, player2card);
	if (earlyWon) {
		deck(PLAYER_ONE)->push_front(player1card);
		deck(PLAYER_TWO)->push_front(player2card);
		return;
	}

	if (winner == PLAYER_ONE) {
		deck(PLAYER_ONE)->push_back(player1card);
		deck(PLAYER_ONE)->push_back(player2card);
	} else {
		deck(PLAYER_TWO)->push_back(player2card);
		deck(PLAYER_TWO)->push_back(player1card);
	}
}
