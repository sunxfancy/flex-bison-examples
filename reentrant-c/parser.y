
%{
#include <stdint.h>
#include <stdio.h>
#include "reentrant_parser.h"
void error(const char* msg);

%}

%define parse.trace
%define parse.error verbose

%union {
    uint64_t integer;
    char *str;
}

/* The driver is passed by reference to the parser and to the scanner. This
 * provides a simple but effective pure interface, not relying on global
 * variables. */
%lex-param {void *scanner} 
%parse-param {void *scanner} {struct reentrant_parser* parser} 

%token FUNCTION

%%

%start program;

program: FUNCTION;


%%

int main(int argc, char *argv[])
{
	reentrant_parser* p = createParser();
    Parse(p);
	return 0;
}


void yyerror(void* lexer, struct reentrant_parser* parser, const char* msg)
{
	fprintf(stderr, "Error: %s\n", msg);
}