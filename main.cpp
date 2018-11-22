#include <iostream>

extern int yyparse();
extern int yydebug;

int main(int argc, char **argv) {
    yyparse();
    return EXIT_SUCCESS;
}