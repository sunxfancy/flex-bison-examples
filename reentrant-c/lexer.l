
%option reentrant noyywrap nounput

%{
#include "parser.h"

%}



%%

"function"   return FUNCTION; 
%%
