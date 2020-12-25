#include <stdbool.h>

struct Rule;

struct Rule newRule(char** line);
int formatRule(char* str, struct Rule* r);
bool isValid(struct Rule* r, char** pw);
