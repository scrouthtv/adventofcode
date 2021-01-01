#include <string>

#include "game.h"

Game::Game() {
}

void Game::add(Player p, int card) {
  if (p == PLAYER_ONE)
		player1deck.push(card);
  else
		player2deck.push(card);
}

void Game::play() {
	int player1card = player1deck.front();
	int player2card = player2deck.front();
	player1deck.pop();
	player2deck.pop();
	
	if (player1card > player2card) {
		player1deck.push(player1card);
		player1deck.push(player2card);
	} else {
		player2deck.push(player2card);
		player2deck.push(player1card);
	}
}

std::string to_string(Game* g) {
	using namespace std;
	string out;

	out.append("Player 1's deck: ");

	queue<int> deckclone = *(g->deck(PLAYER_ONE));

	while (deckclone.size() > 1) {
		out.append(to_string(deckclone.front()) + ", ");
		deckclone.pop();
	}
	if (deckclone.size() > 0)
		out.append(to_string(deckclone.front()));
	out.append("\n");

	out.append("Player 2's deck: ");
	deckclone = *(g->deck(PLAYER_TWO));

	while (deckclone.size() > 1) {
		out.append(to_string(deckclone.front()) + ", ");
		deckclone.pop();
	}
	if (deckclone.size() > 0)
		out.append(to_string(deckclone.front()));
	out.append("\n");

	return out;
}

std::queue<int> * Game::deck(Player p) {
	if (p == PLAYER_ONE) return &player1deck;
	else return &player2deck;
}

bool Game::isWon() {
	return (player1deck.size() == 0 || player2deck.size() == 0);
}

Player Game::winner() {
	if (player1deck.size() == 0) return PLAYER_TWO;
	else return PLAYER_ONE;
}

int Game::score(Player p) {
	std::queue<int> *wdeck = deck(p);
	int score = 0;
	while (wdeck->size() > 0) {
		score += wdeck->front() * wdeck->size();
		wdeck->pop();
	}
	return score;
}
