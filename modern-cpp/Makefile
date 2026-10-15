CXX = g++
CXXFLAGS ?= -O2 -Wall -Wextra -std=c++17
BISON = bison
FLEX = flex
BUILD = build

.PHONY: all clean
all: $(BUILD)/modern-cpp

$(BUILD):
	mkdir -p $@

$(BUILD)/parser.cpp: parser.y | $(BUILD)
	$(BISON) -Wall -Werror --defines=$(BUILD)/parser.hpp -o $@ $<

$(BUILD)/parser.hpp: $(BUILD)/parser.cpp
	@test -f $@ || $(BISON) -Wall -Werror --defines=$@ -o $(BUILD)/parser.cpp parser.y

$(BUILD)/lexer.cpp: lexer.l $(BUILD)/parser.hpp
	$(FLEX) -o $@ $<

$(BUILD)/modern-cpp: main.cpp $(BUILD)/parser.cpp $(BUILD)/lexer.cpp $(BUILD)/parser.hpp
	$(CXX) $(CXXFLAGS) -I$(BUILD) main.cpp $(BUILD)/parser.cpp $(BUILD)/lexer.cpp -o $@

clean:
	rm -rf $(BUILD)
