#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#include "rule.h"

struct Rule {
	char letter; 
	int min;
	int max;
};

bool isValid(struct Rule* r, char** pw) {
	int cs = 0;
	for (int i = 1; i < strlen(*pw); i++) {
		if ((*pw)[i] == r->letter) {
			cs++;
		}
	}
	return cs >= r->min && cs <= r->max;
}

int formatRule(char* str, struct Rule* r) {
	return sprintf(str, "%c * %d - %d", r->letter, r->min, r->max);
}

struct Rule newRule(char** line) {
	char *min, *max, *tok;

	min = strtok(*line, "-");
	max = strtok(NULL, " ");
	tok = strtok(NULL, "");

	struct Rule r;
	r.letter = tok[0];
	r.min = atoi(min);
	r.max = atoi(max);
	return r;
}
