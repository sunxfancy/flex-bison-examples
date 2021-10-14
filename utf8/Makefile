CC = gcc
OPT = -O3 -std=c++11
utf8: lexer.c parser.c 
	$(CC) $(OPT) $^ -o $@

lexer.h lexer.c: lexer.l
	flex --header-file=lexer.h -o lexer.c lexer.l 

parser.h parser.c: parser.y
	bison -d -v -o parser.c parser.y
