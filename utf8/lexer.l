/* this example contains some key code that comes from https://stackoverflow.com/questions/9611682/flexlexer-support-for-unicode/9617585#9617585 */

%{   
#include "parser.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
#define SAVE_TOKEN     yylval.str = maketoken(yytext, yyleng)
#define SAVE_STRING    yylval.str = makestring(yytext, yyleng, 2)

char* maketoken(const char* data, int len);
char* makestring(const char* data, int len, int s);
%}

%option noyywrap

DIGIT    [0-9]

ASC     [\x00-\x7f]
ASCN    [\x00-\t\v-\x7f]
U       [\x80-\xbf]
U2      [\xc2-\xdf]
U3      [\xe0-\xef]
U4      [\xf0-\xf4]

  /* no \x34 "  */
ASCNS    [\x00-\x33\x35-\x7f]  

  /* match any character - single-byte ASCII or multi-byte UTF-8. */
UANY    {ASC}|{U2}{U}|{U3}{U}{U}|{U4}{U}{U}{U}  

  /* UANYN means like UANY but no not match the newline */
UANYN   {ASCN}|{U2}{U}|{U3}{U}{U}|{U4}{U}{U}{U} 

  /* UONLY means match only a UTF-8 extended character, not an ASCII one */
UONLY   {U2}{U}|{U3}{U}{U}|{U4}{U}{U}{U}         

  /* UANYNS means like UANY but no not match the quote "  */
UANYNS  {ASCNS}|{U2}{U}|{U3}{U}{U}|{U4}{U}{U}{U}

%%


[ \t]+         {/* ignore spaces */}
"-"            {return MINUS;}
"+"            {return PLUS;}
"*"            {return MULT;}
"/"            {return DIV;}
"="            {return EQUAL;}

"\n"           {return END;}

"类型"          { return TYPE;}

{UONLY}+        {SAVE_TOKEN; return ID;}

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {yylval.dval = atof(yytext); return NUMBER;}

\"({UANYNS}|\\[\x00-\x7f])+\"   {SAVE_STRING; return STRING; }

.              {printf("Error at line %d: unrecognized symbol \"%s\"\n", yylloc.first_line, yytext); exit(0);}

%%


char* maketoken(const char* data, int len) {
    char* str = (char*) malloc(len+1);
    strncpy(str, data, len);
    str[len] = 0;
    return str;
}

char* makestring(const char* data, int len, int s) {
    char* str = (char*) malloc(len-s+1);
    strncpy(str, data+s-1, len-s);
    str[len-s] = 0;
    if (s == 3) return str;
    return str;
}
