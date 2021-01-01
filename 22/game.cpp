#include <string>
#include <algorithm>

#include "game.h"

Game::Game() {
}

void Game::add(Player p, int card) {
  if (p == PLAYER_ONE)
		player1deck.push_back(card);
  else
		player2deck.push_back(card);
}

void Game::play() {
	int player1card = player1deck.front();
	int player2card = player2deck.front();
	player1deck.pop_front();
	player2deck.pop_front();
	
	if (player1card > player2card) {
		player1deck.push_back(player1card);
		player1deck.push_back(player2card);
	} else {
		player2deck.push_back(player2card);
		player2deck.push_back(player1card);
	}
}

std::string to_string(Game* g) {
	using namespace std;
	string out;

	out.append("Player 1's deck: ");

	deque<int>* deck = g->deck(PLAYER_ONE);
	deque<int>::const_iterator it;

	for (it = deck->begin(); it != deck->end(); ++it) {
		if (it != deck->begin()) out.append(", ");
		out.append(to_string(*it));
	}
	out.append("\n");
	out.append("Player 2's deck: ");

	deck = g->deck(PLAYER_TWO);
	for (it = deck->begin(); it != deck->end(); ++it) {
		if (it != deck->begin()) out.append(", ");
		out.append(to_string(*it));
	}
	out.append("\n");

	return out;
}

std::deque<int> * Game::deck(Player p) {
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
	std::deque<int> *wdeck = deck(p);
	int score = 0;
	while (wdeck->size() > 0) {
		score += wdeck->front() * wdeck->size();
		wdeck->pop_front();
	}
	return score;
}
