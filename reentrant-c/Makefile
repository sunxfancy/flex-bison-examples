CXX = gcc
STD = -std=c11
OPT = -O3

reentrant-c: lexer.o parser.o reentrant_parser.o 
	$(CXX) $^ -o $@

lexer.h lexer.c: lexer.l parser.h 
	flex --header-file=lexer.h -o lexer.c lexer.l 

parser.h parser.c: parser.y
	bison -d -v -o parser.c parser.y

%.o: %.c
	$(CXX) -c $(STD) $(OPT) $< -o $@

