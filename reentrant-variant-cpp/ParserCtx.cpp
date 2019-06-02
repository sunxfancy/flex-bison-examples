#include "ParserCtx.hpp"
#include "lexer.hpp"
#include "parser.hpp"
namespace Elite
{
    
ParserCtx::ParserCtx() {
    yylex_init(&lexer);
    // yyset_in()
    loc = new yy::location();
    parser = new yy::Parser(lexer, *loc, *this);

}

ParserCtx::~ParserCtx() {
    yylex_destroy(lexer);
    delete loc;
    delete parser;
}

} // namespace Elite

