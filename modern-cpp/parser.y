%require "3.8"
%skeleton "lalr1.cc"
%defines
%define api.namespace {calc}
%define api.parser.class {Parser}
%define api.value.type variant
%define api.token.constructor
%define parse.error detailed
%define parse.lac full
%locations
%parse-param {void* scanner} {calc::location& loc}
%lex-param {void* scanner} {calc::location& loc}
%code requires {
#include <string>
}
%code {
#include <iostream>
calc::Parser::symbol_type yylex(void* scanner, calc::location& loc);
}
%token <double> NUMBER "number"
%token PLUS "+" MINUS "-" STAR "*" SLASH "/"
%token LPAREN "(" RPAREN ")" EOL "end of line"
%nterm <double> expr
%left PLUS MINUS
%left STAR SLASH
%precedence NEGATE
%%
input: %empty | input line;
line: EOL | expr EOL { std::cout << $1 << '\n'; };
expr:
  NUMBER
| expr PLUS expr { $$ = $1 + $3; }
| expr MINUS expr { $$ = $1 - $3; }
| expr STAR expr { $$ = $1 * $3; }
| expr SLASH expr {
    if ($3 == 0) throw syntax_error(@3, "division by zero");
    $$ = $1 / $3;
  }
| MINUS expr %prec NEGATE { $$ = -$2; }
| LPAREN expr RPAREN { $$ = $2; }
;
%%
void calc::Parser::error(const location_type& where, const std::string& message) {
  std::cerr << where << ": " << message << '\n';
}
