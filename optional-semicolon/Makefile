CC = gcc
STD = -std=c11
OPT = -O3

optional-semicolon: lexer.o parser.o sliplist.o
	$(CC) $^ -o $@

lexer.h lexer.c: lexer.l parser.h 
	flex --header-file=lexer.h -o lexer.c lexer.l 

parser.h parser.c: parser.y
	bison -d -v -o parser.c parser.y

%.o: %.c
	$(CC) -c $(STD) $(OPT) $< -o $@

