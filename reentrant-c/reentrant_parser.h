#ifndef REENTRANT_PARSER_H
#define REENTRANT_PARSER_H


typedef struct reentrant_parser
{
    void* lexer;
    int data[300];
} reentrant_parser;

reentrant_parser* createParser();
void Parse(reentrant_parser* p);

#endif