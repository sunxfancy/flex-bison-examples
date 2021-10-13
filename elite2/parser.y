
/* Require bison minimal version */
%require "3.0.4"

/* use newer C++ skeleton file */
%skeleton "lalr1.cc"

/* write out a header file containing the token defines */
%defines

/* namespace to enclose parser in */
%name-prefix="yy"

/* set the parser's class identifier */
%define api.parser.class {Parser}

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
yy::Parser::symbol_type yylex(void* yyscanner, yy::location& loc, class Elite::ParserCtx& ctx);
}


%token END 0;

	/* specify tokens, type of non-terminals and terminals here */

%token <std::string> ID INTEGER DOUBLE STRING CHAR
%token CEQ CNE CGE CLE MBK
%token '<' '>' '=' '+' '-' '*' '/' '%' '^' '&' '|' '~' '@' '?' ':'
%token PP SS LF RF AND OR '!' NSP PE SE ME DE AE OE XE MODE FLE FRE SZ MOV

%token CONST NEW DELETE
%token TRUE FALSE NULL_T

%left AE OE XE MODE FLE FRE
%left PE SE    
%left ME DE
%left '&' '|'
%left CEQ CNE CLE CGE '<' '>' '='
%left '+' '-'
%left '*' '/' '%' '^'
%left '.'
%right '~' '!' PP SS
%left '(' '[' ')' ']'
%left MBK '@'

	/* end of token specifications */


/* The driver is passed by reference to the parser and to the scanner. This
 * provides a simple but effective pure interface, not relying on global
 * variables. */
%lex-param {void *scanner} {yy::location& loc} { class Elite::ParserCtx& ctx }
%parse-param {void *scanner} {yy::location& loc} { class Elite::ParserCtx& ctx }


%%

%start program;

program
	: elements
	;

list
	: '(' elements ')'
	| '[' elements ']'
	| '{' elements '}'
	;

elements
	: elements element
	| %empty
	;

element
	: expr
    | type
    ;

type
    : ID 
    | CONST ID 
    | '*' ID 
    | CONST '*' ID 
    | type SZ 
    ;

numeric 
	: INTEGER 
    | DOUBLE 
    ;

var_exp 
	: ID 
    | numeric 
    | STRING 
    | TRUE
    | FALSE
    | NULL_T 
    ;

new_expr 
    : NEW type 
    | NEW type '(' call_args ')'  
    | new_expr '[' call_args ']' 
    ;

delete_expr : DELETE expr 
            ;

expr 
	: expr '=' expr 
	| expr MOV expr 
	| expr '(' call_args ')' 
    | expr '[' call_args ']'  
    | new_expr
    | var_exp
    | expr CEQ expr 
    | expr CNE expr 
    | expr CLE expr 
    | expr CGE expr 
    | expr '<' expr 
    | expr '>' expr 
    | expr '<' '<' expr 
    | expr '>' '>' expr 
    | expr '+' expr 
    | expr '-' expr 
    | expr '*' expr 
    | expr '/' expr 
    | expr '%' expr 
    | expr '^' expr 
    | expr '&' expr 
    | expr '|' expr 
    | expr PE expr 
    | expr SE expr 
    | expr ME expr 
    | expr DE expr 
    | expr MODE expr 
    | expr XE expr 
    | expr AE expr 
    | expr OE expr 
    | expr FLE expr 
    | expr FRE expr 
    | expr '.' expr 
    | '~' expr 
    | '!' expr 
    | PP expr 
    | SS expr 
    | expr PP 
    | expr SS 
    | '(' expr ')'  /* ( expr ) */  
    ;

call_arg  :  expr 
          |  ID '=' expr 
          ;

call_args : %empty 
          | call_arg 
          | call_args ',' call_arg  
          ;

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