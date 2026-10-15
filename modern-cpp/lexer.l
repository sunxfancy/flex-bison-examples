%option reentrant noyywrap nounput noinput nodefault
%{
#include "parser.hpp"
#include <cstdlib>
#include <string>
#define YY_DECL calc::Parser::symbol_type yylex(yyscan_t yyscanner, calc::location& loc)
#define YY_USER_ACTION loc.step(); loc.columns(yyleng);
%}
%%
[ \t]+                        {}
\r\n|\n|\r                     { loc.lines(1); return calc::Parser::make_EOL(loc); }
([0-9]+(\.[0-9]*)?|\.[0-9]+)   { return calc::Parser::make_NUMBER(std::strtod(yytext, nullptr), loc); }
"+"                           { return calc::Parser::make_PLUS(loc); }
"-"                           { return calc::Parser::make_MINUS(loc); }
"*"                           { return calc::Parser::make_STAR(loc); }
"/"                           { return calc::Parser::make_SLASH(loc); }
"("                           { return calc::Parser::make_LPAREN(loc); }
")"                           { return calc::Parser::make_RPAREN(loc); }
<<EOF>>                       { loc.step(); return calc::Parser::make_YYEOF(loc); }
.                             { throw calc::Parser::syntax_error(loc, "invalid character: " + std::string(yytext, yyleng)); }
%%
