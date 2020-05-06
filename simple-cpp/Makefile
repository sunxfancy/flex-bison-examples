CC = g++
OPT = -O3
simple-cpp: lexer.cpp parser.cpp
	$(CC) $(OPT) $^ -o $@

lexer.h lexer.cpp: lexer.l
	flex --header-file=lexer.h -o lexer.cpp lexer.l 

parser.h parser.cpp: parser.y
	bison -d -v -o parser.cpp parser.y
