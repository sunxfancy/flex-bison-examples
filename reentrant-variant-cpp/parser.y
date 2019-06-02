
/* Require bison minimal version */
%require "3.0.4"

/* use newer C++ skeleton file */
%skeleton "lalr1.cc"

/* write out a header file containing the token defines */
%defines

/* namespace to enclose parser in */
%name-prefix="yy"

/* set the parser's class identifier */
%define "parser_class_name" "Parser"

/* it will generate a location class which can be used in your lexer */
%locations

/* use the constructor for each token, and make_TOKENNAME functions will be generated */
%define api.token.constructor

/* use the variant type for $1~$n and $$ those variables */
%define api.value.type variant


%define parse.trace
%define parse.error verbose


%code requires
{
	/* you may need these header files 
	 * add more header file if you need more
	 */
#include <list>
#include <string>
#include <functional>
#include "ParserCtx.hpp"

	/* define the sturctures using as types for non-terminals */

	/* end the structures for non-terminal types */
}


%code
{
yy::Parser::symbol_type yylex(void* yyscanner, yy::location& loc);
}


%token END 0;

	/* specify tokens, type of non-terminals and terminals here */
%token FUNCTION
	/* end of token specifications */


/* The driver is passed by reference to the parser and to the scanner. This
 * provides a simple but effective pure interface, not relying on global
 * variables. */
%lex-param {void *scanner} {yy::location& loc}
%parse-param {void *scanner} {yy::location& loc} { class Elite::ParserCtx& ctx }



%%



%start program;

	/* define your grammars here use the same grammars 
	 * you used in Phase 2 and modify their actions to generate codes
	 * assume that your grammars start with program
	 */

program: FUNCTION;


%%

int main(int argc, char *argv[])
{
	Elite::ParserCtx ctx;
	return ctx.parser->parse();
}

void yy::Parser::error(const yy::location& l, const std::string& m)
{
	std::cerr << l << ": " << m << std::endl;
}