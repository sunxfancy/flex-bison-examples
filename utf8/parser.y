/* calculator. */
%{
 #include <stdio.h>
 #include <stdlib.h>
 #include "lexer.h"
 void yyerror(const char *msg);

%}

%union{
  double dval;
  char* str;
  int ival;
}

%error-verbose
%locations

%start input
%token MULT DIV PLUS MINUS EQUAL L_PAREN R_PAREN END TYPE
%token <dval> NUMBER
%token <str> STRING ID
%type <dval> exp
%type <cval> input
%left PLUS MINUS
%left MULT DIV
%nonassoc UMINUS


%% 
input: line 
     | input line 
     ;

line:	TYPE ID EQUAL NUMBER END { printf("%s\t数字类型 值：%f\n", $2, $4);}
    | TYPE ID EQUAL STRING END { printf("%s\t字符串类型 内容: %s\n", $2, $4);}
	 ;

%%

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r");
      if (yyin == NULL){
         printf("syntax: %s filename\n", argv[0]);
      }//end if
   }//end if
   yyparse(); // Calls yylex() for tokens.
   return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d: %s\n", yylloc.first_line, msg);
}
