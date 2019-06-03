
%option reentrant noyywrap nounput

%{
#include <iostream>
#define YY_DECL yy::Parser::symbol_type yylex(yyscan_t yyscanner, yy::location& loc, class Elite::ParserCtx& ctx)

#define YY_USER_ACTION loc.columns(yyleng);
#define yyterminate() return Parser::make_END(loc)

#include "parser.hpp"

using namespace yy;
typedef yy::Parser::token token;
typedef yy::Parser::token_type token_type;
%}

	/* your definitions here */

	/* your definitions end */

%%

%{
	loc.step();
%}

	/* your rules here */


"/*"([^\*]|(\*)*[^\*/])*(\*)*"*/" ; /* 就是这种注释 */ 

#[^\n]*\n               ; /* 井号注释 */ 
"//"[^\n]*\n            ; /* 双线注释 */ 

[ \t\v\r\n\f]             ; /* 过滤空白字符 */

    /* 一些双元运算符 */
"++"                    return Parser::symbol_type( token::PP, loc );
"--"                    return Parser::symbol_type( token::SS, loc );
"<-"                    return Parser::symbol_type( token::LF, loc );
"->"                    return Parser::symbol_type( token::RF, loc );
"&&"                    return Parser::symbol_type( token::AND, loc );
"||"                    return Parser::symbol_type( token::OR, loc );
"!"                     return Parser::symbol_type( token_type('!'), loc );
"::"                    return Parser::symbol_type( token::NSP, loc );

":="                    return Parser::symbol_type( token::MOV, loc );
"+="                    return Parser::symbol_type( token::PE, loc );
"-="                    return Parser::symbol_type( token::SE, loc );
"*="                    return Parser::symbol_type( token::ME, loc );
"/="                    return Parser::symbol_type( token::DE, loc );
"&="                    return Parser::symbol_type( token::AE, loc );
"|="                    return Parser::symbol_type( token::OE, loc );
"^="                    return Parser::symbol_type( token::XE, loc );
"%="                    return Parser::symbol_type( token::MODE, loc );
"<<="                   return Parser::symbol_type( token::FLE, loc );
">>="                   return Parser::symbol_type( token::FRE, loc );


    /* 比较运算符 */
"=="                    return Parser::symbol_type( token::CEQ, loc );
"<="                    return Parser::symbol_type( token::CLE, loc );
">="                    return Parser::symbol_type( token::CGE, loc );
"!="                    return Parser::symbol_type( token::CNE, loc );
"<"                     return Parser::symbol_type( token_type('<'), loc );
">"                     return Parser::symbol_type( token_type('>'), loc );


    /* 界符 */
"("                     return Parser::symbol_type( token_type('('), loc );
")"                     return Parser::symbol_type( token_type(')'), loc );
"["                     return Parser::symbol_type( token_type('['), loc );
"]"                     return Parser::symbol_type( token_type(']'), loc );
"{"                     return Parser::symbol_type( token_type('{'), loc );
"}"                     return Parser::symbol_type( token_type('}'), loc );
"."                     return Parser::symbol_type( token_type('.'), loc );
","                     return Parser::symbol_type( token_type(','), loc );
"?"                     return Parser::symbol_type( token_type('?'), loc );
":"                     return Parser::symbol_type( token_type(':'), loc );
";"                     return Parser::symbol_type( token_type(';'), loc );
"[]"                    return Parser::symbol_type( token::SZ, loc );


    /* 基本运算符 */
"="                     return Parser::symbol_type( token_type('='), loc );
"+"                     return Parser::symbol_type( token_type('+'), loc );
"-"                     return Parser::symbol_type( token_type('-'), loc );
"*"                     return Parser::symbol_type( token_type('*'), loc );
"/"                     return Parser::symbol_type( token_type('/'), loc );
"%"                     return Parser::symbol_type( token_type('%'), loc );
"^"                     return Parser::symbol_type( token_type('^'), loc );
"&"                     return Parser::symbol_type( token_type('&'), loc );
"|"                     return Parser::symbol_type( token_type('|'), loc );
"~"                     return Parser::symbol_type( token_type('~'), loc );

    /* 宏运算符 */
"@"                     return Parser::symbol_type( token_type('@'), loc );
",@"                    return Parser::symbol_type( token::MBK, loc );
"`"                     return Parser::symbol_type( token_type('`'), loc );

    /* 特殊运算符 */
"new"                   return Parser::make_NEW(loc);
"delete"                return Parser::make_DELETE(loc);

    /* 特殊值 */
"null"                  return Parser::make_NULL_T(loc);
"true"                  return Parser::make_TRUE(loc);
"false"                 return Parser::make_FALSE(loc);


[a-zA-Z_][a-zA-Z0-9_]*  return Parser::make_ID(yytext, loc); /* 标识符 */

-?[0-9]*\.[0-9]*        return Parser::make_DOUBLE(yytext, loc);
-?[0-9]+                return Parser::make_INTEGER(yytext, loc);
0x[0-9A-Fa-f]+          return Parser::make_INTEGER(yytext, loc);

\"(\\.|[^\\"])*\"       return Parser::make_STRING(yytext, loc); /* 字符串 */
@\"(\\.|[^\\"])*\"      return Parser::make_STRING(yytext, loc); /* 无转义字符串 */
\'(\\.|.)\'             return Parser::make_CHAR(yytext, loc);   /* 字符 */

.				{std::cerr << loc << ": " << "token error" << std::endl; exit(1);}

	/* your rules end */

%%
