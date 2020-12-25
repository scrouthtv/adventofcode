#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct Rule {
	char letter; 
	int min;
	int max;
};

int formatRule(char* str, struct Rule* r);
struct Rule newRule(char** line);
bool isValid(struct Rule* r, char** pw);

int main(int argc, char** argv) {
	const char* path = "input";
	char* line = NULL;
	size_t len = 0;
	ssize_t read = 0;

	FILE* f = fopen(path, "r");
	if (f == NULL) exit(EXIT_FAILURE);

	read = getline(&line, &len, f);

	char* pw;
	struct Rule r;
	char str[80];
	int valids = 0, invalids = 0;
	while (read != -1) {
		line = strtok(line, ":");
		pw = strtok(NULL, "\n");
		r = newRule(&line);
		formatRule(str, &r);
		/*printf("pw: %s\n", pw);
		printf("Rule: %s\n", str);*/
		/*printf("Pw%s with rule %s is %svalid\n", pw, str,
				isValid(&r, &pw) ? "" : "not ");*/
		if (isValid(&r, &pw)) valids++;
		else invalids++;

		read = getline(&line, &len, f);
	}
	fclose(f);

	printf("Found %d valid and %d invalid passwords.\n", valids, invalids);
}

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
