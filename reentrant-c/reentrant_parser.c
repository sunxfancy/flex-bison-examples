#include "reentrant_parser.h"
#include <stdlib.h>

reentrant_parser* createParser() {
    reentrant_parser* p = (reentrant_parser*) malloc(sizeof(reentrant_parser));
    return p;
}


void Parse(reentrant_parser* p) {
    yylex_init(&p->lexer);
    yyparse(p->lexer, p);
}
