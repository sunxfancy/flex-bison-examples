%{

#include "parser.h"
#include <stdlib.h>

#define SAVE_TOKEN     yylval.str = maketoken(yytext, yyleng)
#define SAVE_STRING    yylval.str = makestring(yytext, yyleng, 2)
#define SAVE_STRING_NC yylval.str = makestring(yytext, yyleng, 3)

char* maketoken(const char* data, int len);
char* makestring(const char* data, int len, int s);

#ifdef _WIN32

/*windows compatibility case*/  
#define YY_NO_UNISTD_H
#include <io.h>  
#define isatty _isatty  
#define fileno _fileno  

#endif

%}

%option yylineno
%option noyywrap

%%

"/*"([^\*]|(\*)*[^\*/])*(\*)*"*/" ; /* 就是这种注释 */
"//".*                  ; /* 双线注释 */

[ \t\v\f]               ; /* 过滤空白字符 */

\n+                     return '\n';

    /* 界符 */
[()\[\]{}.:`;]          return *yytext;
    /* 运算符 */
[+\-*/&|^~!%=,]         return *yytext;

[><]                    return *yytext;
"<="                    return LTE;
">="                    return GTE;
"!="                    return NE;
"=="                    return EQ;

"var"                   return VAR;
"class"                 return CLASS;
"defun"                 return DEFUN;
"defmacro"              return DEFMACRO;
"return"                return RETURN;
"yield"                 return YIELD;
"if"                    return IF;
"else"                  return ELSE;
"while"                 return WHILE;
"break"                 return BREAK;
"continue"              return CONTINUE;
"do"                    return DO;
"for"                   return FOR;
"foreach"               return FOREACH;

"nil"                   return T_NIL;
"true"                  return T_TRUE;
"false"                 return T_FALSE;

[a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TID; /* 标识符 */

[0-9]*\.[0-9]*          SAVE_TOKEN; return DOUBLE;
[0-9]+                  SAVE_TOKEN; return INTEGER;
0x[0-9A-Fa-f]+          SAVE_TOKEN; return INTEGER;

\"(\\.|[^\\"])*\"       SAVE_STRING; return STRING; /* 字符串 */
@\"(\\.|[^\\"])*\"      SAVE_STRING_NC; return STRING; /* 无转义字符串 */
\'(\\.|.)\'             SAVE_STRING; return CHAR;   /* 字符 */

.                       printf("Unknown Token!\n"); yyterminate();

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

void slip_reset_file(FILE* f) {
    yyrestart(f);
}

void slip_scan_string(const char* str)
{
    yy_switch_to_buffer(yy_scan_string(str));
}
