CC = g++
OPT = -O3 -std=c++11
simple-cpp: lexer.cpp parser.cpp
	$(CC) $(OPT) $^ -o $@

lexer.hpp lexer.cpp: lexer.l
	flex --header-file=lexer.hpp -o lexer.cpp lexer.l 

parser.hpp parser.cpp: parser.y
	bison -d -v -o parser.cpp parser.y
