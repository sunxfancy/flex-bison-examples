%{

#include <stdio.h>
#include <stdlib.h> 
#include "sliplist.h"

#define YYERROR_VERBOSE 1

union slip_Node *programBlock; /* the top level root node of our final AST */

extern int yylex();
extern int yylineno;
extern char* yytext;
extern int yyleng;

void yyerror(const char *s);

#define ID(x) (slip_Node*)slipL_create_IDNode(x)
#define String(x) (slip_Node*)slipL_create_StringNode(x)
#define Float(x) (slip_Node*)slipL_create_FloatNodeFromStr(x)
#define Int(x) (slip_Node*)slipL_create_IntNodeFromStr(x)
#define List(x) (slip_Node*)slipL_create_ListNode(x)
#define mkl slipL_makeList
#define add slipL_addBrother
#define concat slipL_concat
%}


/* This is the key feature we contributed to the new template - add the yyfilter funtion call */
%skeleton "./bison.m4"

%locations 

/* Represents the many different ways we can access our data */
%union {
    union slip_Node *node;
    char *str;
}



/* Define our terminal symbols (tokens). This should

   match our tokens.l lex file. We also define the node type

   they represent.

 */

%token <str> TID INTEGER DOUBLE CHAR STRING
%token IF ELSE RETURN YIELD WHILE DO FOR FOREACH BREAK CONTINUE
%token LTE GTE EQ NE 
%token DEFUN DEFMACRO CLASS VAR
%token T_NIL T_TRUE T_FALSE

/*
   Define the type of node our nonterminal symbols represent.
   The types refer to the %union declaration above. Ex: when
   we call an ident (defined by union type ident) we are really
   calling an (NIdentifier*). It makes the compiler happy.
 */

%type <node> program value list_node list src_list list_token
%type <node> expr exprs exprss block statement statements defargs
%type <node> defmacro_state defun_state if_state for_state while_state ret_state select_state call_state assign_state

/* Operator precedence for mathematical operators */

%left  '+'  '-'
%left  '*'  '/'
%left  '('  '['
%left  '.'
%right '='


%start program

%%

program 
    : statements { programBlock = $1; }
    ;

/* ------------ Meta List ------------- */

value 
    : TID       { $$ = ID($1); }
    | STRING    { $$ = String($1); }
    | DOUBLE    { $$ = Float($1); }
    | CHAR      { $$ = Int($1); }
    | INTEGER   { $$ = Int($1); }
    ;

list_token 
    : IF        { $$ = ID("if"); }
    | ELSE      { $$ = ID("else"); }
    | DEFUN     { $$ = ID("defun"); }
    | DEFMACRO  { $$ = ID("defmacro"); }
    | RETURN    { $$ = ID("return"); }
    | WHILE     { $$ = ID("while"); }
    | '+'       { $$ = ID("+"); }
    | '-'       { $$ = ID("-"); }
    | '*'       { $$ = ID("*"); }
    | '/'       { $$ = ID("/"); }
    | '='       { $$ = ID("="); }
    ;

list_node 
    : value
    | list
    | list_token
    | list_node value       { $$ = $1; add($1, $2); }
    | list_node list        { $$ = $1; add($1, $2); }
    | list_node list_token  { $$ = $1; add($1, $2); }
    ;

list 
    : '(' list_node ')' { $$ = List($2); }
    ;

src_list 
    : '`' list { $$ = $2; }
    ;

/* ------------- Expressions ----------------- */


exprs 
    : expr
    | expr ',' exprs   { $$ = $1; add($1, $3); }
    ;

exprss 
    : expr ',' expr     { $$ = $1; add($1, $3); }
    | expr ',' exprss   { $$ = $1; add($1, $3); }
    ;

expr 
    : expr '+' expr { $$ = mkl(3, ID("+"), $1, $3); }
    | expr '-' expr { $$ = mkl(3, ID("-"), $1, $3); }
    | expr '*' expr { $$ = mkl(3, ID("*"), $1, $3); }
    | expr '/' expr { $$ = mkl(3, ID("/"), $1, $3); }
    | expr '=' expr { $$ = mkl(3, ID("="), $1, $3); }
    | '(' exprs ')'  { $$ = $2; }
    | value
    | call_state
    | select_state
    ;

call_state 
    : expr '(' exprs ')'    { $$ = $1; concat($$, $3); }
    | expr '(' ')'          { $$ = $1; }
    ;

select_state 
    : expr '[' exprs ']'    { $$ = mkl(3, ID("select"), $1, $3); }
    | expr '.' TID          { $$ = mkl(3, ID("."), $1, ID($3)); }
    ;


/* ---------------- Statements --------------- */

block 
    : '{' statements '}' { $$ = $2; }
    ;

statements 
    : statement ';'
    | statements  statement ';' { $$ = $1; add($1, $2); }
    ;

statement 
    : if_state          { $$ = List($1); }
    | while_state       { $$ = List($1); }
    | for_state         { $$ = List($1); }
    | ret_state         { $$ = List($1); }
    | defun_state       { $$ = List($1); }
    | defmacro_state    { $$ = List($1); }
    | src_list
    | expr              { $$ = List($1); }
    | assign_state  
    ;

assign_state 
    : exprss '=' exprss { $$ = List(mkl(3, ID("="), $1, $3)); }
    ;

for_state 
    : FOR '(' expr ';' expr ';' expr ')' block
    | FOR '(' expr ';' expr ';' expr ')' statement
    ;

if_state 
    : IF expr block                             { $$ = mkl(3, ID("if"), $2, $3); }
    | IF '(' expr ')' statement                 { $$ = mkl(3, ID("if"), $3, $5); }
    | IF expr block ELSE block                  { $$ = mkl(4, ID("if"), $2, $3, $5); }
    | IF '(' expr ')' statement ELSE statement  { $$ = mkl(4, ID("if"), $3, $5, $7); }
    ;

while_state 
    : WHILE expr block { $$ = mkl(3, ID("while"), $2, $3); }
    ;

ret_state 
    : RETURN expr { $$ = mkl(2, ID("return"), $2); }
    ;

/* --------------- Define Function & Macro -------------------- */

defargs 
    : TID               { $$ = ID($1); }
    | defargs ',' TID   { $$ = $1; add($1, ID($3)); }
    ;

defun_state 
    : DEFUN TID '(' defargs ')' block   { $$ = mkl(3, ID("defun"), ID($2), List($4)); concat($$, $6); }
    | DEFUN '(' defargs ')' block       { $$ = mkl(3, ID("defun"), 0, List($3)); concat($$, $5); }
    ;

defmacro_state 
    : DEFMACRO TID '(' defargs ')' block    { $$ = mkl(3, ID("defmacro"), ID($2), List($4)); concat($$, $6);}
    | DEFMACRO '(' defargs ')' block        { $$ = mkl(3, ID("defun"), 0, List($3)); concat($$, $5); }
    ;

%%

void yyerror(const char* s){
    fprintf(stderr, "%s \n", s);
    fprintf(stderr, "line %d: ", yylineno);
    fprintf(stderr, "text %s \n", yytext);
    exit(1);
}

/* This filter will try to use ';' instead '\n' as the next token.
 * If the transition works without error, we will issue a ';' token,
 * Othervise we will ignore '\n' and produce the next token
 */

int yyfilter(int yychar, int yyn, int yystate, yy_state_t *yyssp) {
    if (yychar == '\n') {
        yysymbol_kind_t yytoken = YYTRANSLATE (';');

start:  yyn = yypact[yystate];
        if (yypact_value_is_default (yyn)) goto defact;
        yyn += yytoken;
        if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken) {
            /* default action */
defact:     yyn = yydefact[yystate];
            if (yyn == 0) { 
                /* return yylex(); */
                do yychar = yylex(); while (yychar == '\n'); 
                return yychar;
            }
            else goto reduce;
        } else { // table contains action
            yyn = yytable[yyn];
            if (yyn <= 0)
            {  // reduce case
                yyn = -yyn;
reduce:         yyssp -= yyr2[yyn];
                const int yylhs = yyr1[yyn] - YYNTOKENS;
                const int yyi = yypgoto[yylhs] + *yyssp;
                yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
                        ? yytable[yyi]
                        : yydefgoto[yylhs]);
                goto start;
            } else { // shift case
                return ';'; 
            }
        }
        return ';';
    }
    return yychar;
}


int main(int argc,const char *argv[]) {
    const char *file_in_name = argv[1];
    slip_Node* l = slipL_parseFile(file_in_name);
    return 0;
}