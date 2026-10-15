#include "parser.hpp"
#include <iostream>
#include <memory>

// Flex's reentrant scanner handle is opaque; no global scanner state is used.
int yylex_init(void** scanner);
int yylex_destroy(void* scanner);

int main() {
  void* raw = nullptr;
  if (yylex_init(&raw) != 0) {
    std::cerr << "cannot initialize scanner\n";
    return 1;
  }
  std::unique_ptr<void, decltype(&yylex_destroy)> scanner(raw, &yylex_destroy);
  calc::location loc;
  calc::Parser parser(scanner.get(), loc);
  return parser.parse();
}
