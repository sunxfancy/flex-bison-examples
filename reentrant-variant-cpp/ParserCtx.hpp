#pragma once

namespace yy {
    class Parser;
    class location;
}

namespace Elite
{

class ParserCtx {
public:
    ParserCtx();
    ~ParserCtx();

    void* lexer;
    yy::location* loc;
    yy::Parser* parser;
};

} // namespace Elite
