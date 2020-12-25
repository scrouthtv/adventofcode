#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#include "rule.h"

struct Rule {
	char letter; 
	int posa;
	int posb;
};

bool isValid(struct Rule* r, char** pw) {
	return (*pw)[r->posa] == r->letter ^ 
		(*pw)[r->posb] == r->letter;
}

int formatRule(char* str, struct Rule* r) {
	return sprintf(str, "%c @ %d / %d", r->letter, r->posa, r->posb);
}

struct Rule newRule(char** line) {
	char *posa, *posb, *tok;

	posa = strtok(*line, "-");
	posb = strtok(NULL, " ");
	tok = strtok(NULL, "");

	struct Rule r;
	r.letter = tok[0];
	r.posa = atoi(posa);
	r.posb = atoi(posb);
	return r;
}
