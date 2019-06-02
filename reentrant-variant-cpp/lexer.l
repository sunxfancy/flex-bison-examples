
%option reentrant noyywrap nounput

%{
#include <iostream>
#define YY_DECL yy::Parser::symbol_type yylex(yyscan_t yyscanner, yy::location& loc)

#define YY_USER_ACTION loc.columns(yyleng);
#define yyterminate() return yy::Parser::make_END(loc)

#include "parser.hpp"

%}

	/* your definitions here */

	/* your definitions end */

%%

%{
	loc.step();
%}

	/* your rules here */

	/* use this structure to pass the Token :
	 * return yy::parser::make_TokenName(loc)
	 * if the token has a type you can pass it's value
	 * as the first argument. as an example we put
	 * the rule to return token function.
	 */

function       	{return yy::Parser::make_FUNCTION(loc);}

[ \n\r\t\v]		{}

.				{std::cerr << loc << ": " << "token error" << std::endl; exit(1);}


	/* if you didn't define #define yyterminate() at beginnign, you will need 
	   this rule to match the end of file */
    /* <<EOF>>	{return yy::Parser::make_END(loc);} */
	/* your rules end */

%%
