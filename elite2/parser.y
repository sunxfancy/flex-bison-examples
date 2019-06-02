
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

%token <std::string> ID INTEGER DOUBLE STRING CHAR
%token CEQ CNE CGE CLE MBK
%token '<' '>' '=' '+' '-' '*' '/' '%' '^' '&' '|' '~' '@' '?' ':'
%token PP SS LF RF AND OR '!' NSP PE SE ME DE AE OE XE MODE FLE FRE SZ MOV


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
%lex-param {void *scanner} {yy::location& loc}
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

types : ID { $$ = TypeNode::Create($1, false); }
      | CONST ID { $$ = TypeNode::Create($2, true); }
      | '*' ID { $$ = TypeNode::Create($2, false, true); }
      | CONST '*' ID { $$ = TypeNode::Create($3, true, true); }
      | types SZ { $$ = $1; ((TypeNode*)$1)->addDimension(); }
      ;

numeric 
	: INTEGER { $$ = IntNode::Create($1); }
    | DOUBLE { $$ = FloatNode::Create($1); }
    ;

var_exp 
	: ID { $$ = IDNode::Create($1); }
    | numeric 
    | STRING { $$ = StringNode::Create($1); }
    | KWS_TSZ { $$ = IDNode::Create($1); }
    ;

new_expr : NEW type { $$ = Node::make_list(3, IDNode::Create("new"), $2, Node::Create()); }
         | NEW type '(' call_args ')'  { $$ = Node::make_list(3, IDNode::Create("new"), $2, Node::Create($4)); }
         | new_expr '[' call_args ']' { $$ = $1; $1->addBrother(Node::Create($3)); }
         ;

delete_expr : DELETE expr { $$ = Node::make_list(2, IDNode::Create("delete"), $2); }
            | DELETE '[' ']' expr { $$ = Node::make_list(2, IDNode::Create("delete[]"), $4); }
            ;

expr 
	: expr '=' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("="), $1, $3); }
	| expr MOV expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create(":="), $1, $3); }
	| expr '(' call_args ')' { $$ = Node::make_list(2, IDNode::Create("call"), $1); $$->addBrother($3); }
    | expr '[' call_args ']' { $$ = Node::make_list(2, IDNode::Create("select"), $1); $$->addBrother($3); } 
    | new_expr
    | var_exp
    | expr CEQ expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("=="), $1, $3); }
    | expr CNE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("!="), $1, $3); }
    | expr CLE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("<="), $1, $3); }
    | expr CGE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create(">="), $1, $3); }
    | expr '<' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("<"), $1, $3); }
    | expr '>' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create(">"), $1, $3); }
    | expr '<' '<' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("<<"), $1, $3); }
    | expr '>' '>' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create(">>"), $1, $3); }
    | expr '+' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("+"), $1, $3); }
    | expr '-' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("-"), $1, $3); }
    | expr '*' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("*"), $1, $3); }
    | expr '/' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("/"), $1, $3); }
    | expr '%' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("%"), $1, $3); }
    | expr '^' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("^"), $1, $3); }
    | expr '&' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("&"), $1, $3); }
    | expr '|' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("|"), $1, $3); }
    | expr PE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("+="), $1, $3); }
    | expr SE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("-="), $1, $3); }
    | expr ME expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("*="), $1, $3); }
    | expr DE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("/="), $1, $3); }
    | expr MODE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("%="), $1, $3); }
    | expr XE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("^="), $1, $3); }
    | expr AE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("&="), $1, $3); }
    | expr OE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("|="), $1, $3); }
    | expr FLE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("<<="), $1, $3); }
    | expr FRE expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create(">>="), $1, $3); }
    | expr '.' expr { $$ = Node::make_list(4, IDNode::Create("opt2"), IDNode::Create("."), $1, $3); }
    | '~' expr { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("~"), $2); }
    | '!' expr { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("!"), $2); }
    | PP expr { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("++"), $2); }
    | SS expr { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("--"), $2); }
    | expr PP { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("b++"), $1); }
    | expr SS { $$ = Node::make_list(3, IDNode::Create("opt1"), IDNode::Create("b--"), $1); }
    | '(' expr ')'  /* ( expr ) */  { $$ = $2; }
    ;

call_arg  :  expr { $$ = $1;  }
          |  ID '=' expr { $$ = Node::make_list(3, IDNode::Create("="), $1, $3); }
          ;

call_args : %empty { $$ = NULL; }
          | call_arg { $$ = Node::getList($1); }
          | call_args ',' call_arg  { $$ = $1; $$->addBrother(Node::getList($3)); }
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