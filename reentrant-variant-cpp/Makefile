CXX = g++
STD = -std=c++11
OPT = -O3

reentrant-variant-cpp: lexer.o parser.o ParserCtx.o 
	$(CXX) $^ -o $@

lexer.hpp lexer.cpp: lexer.l parser.hpp 
	flex --header-file=lexer.hpp -o lexer.cpp lexer.l 

parser.hpp parser.cpp: parser.y
	bison -d -v -o parser.cpp parser.y

%.o: %.cpp
	$(CXX) -c $(STD) $(OPT) $< -o $@

