%{
#include <iostream>

extern int yylex();
extern void yyerror(const char* s, ...);
%}

%define parse.trace

/* available storable data types */
%union {
    int value;
}

/* tokens */
%token <value> TOK_INTEGER
%token TOK_PLUS TOK_MINUS TOK_TIMES TOK_DIVIDE TOK_MODULUS
%token TOK_NEWLINE TOK_EOF

/* non-terminal symbol types */
%type <value> program statements statement expression

/* starting rule */
%start program

%%

program
    : statements
    ;

statements
    : statement
    | statements statement
    ;

statement
    : TOK_NEWLINE { $$ = 0 /* NULL */; }
    | expression TOK_NEWLINE { std::cout << "val = " << $1 << std::endl; }
    ;

expression
    : TOK_INTEGER { $$ = $1; }
    | expression TOK_PLUS expression { $$ = $1 + $3; }
    | expression TOK_MINUS expression { $$ = $1 - $3; }
    | expression TOK_TIMES expression { $$ = $1 * $3; }
    | expression TOK_DIVIDE expression { $$ = $1 / $3; }
    | expression TOK_MODULUS expression { $$ = $1 % $3; }
    ;

%%