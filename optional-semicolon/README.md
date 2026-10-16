# optional-semicolon — Optional semicolons / 可选分号

## Overview / 简介

A Slip-style grammar that probes Bison parse tables to insert a semicolon when a newline can end a statement, while allowing incomplete expressions to continue.

Slip 风格语法，通过探测 Bison 解析表，在换行可结束语句时插入分号，同时允许未完成的表达式跨行。

## Requirements / 依赖

Flex, Bison with support for the bundled custom skeleton, a C11 compiler, and Make or CMake 3.5+. / 需要 Flex、兼容自带定制 skeleton 的 Bison、C11 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
./optional-semicolon test.txt
```

Pass an input filename. The sample mixes explicit and omitted semicolons in function calls; output contains parser debugging and the resulting list-based AST, not execution of those calls. / 必须传入文件名；示例混用显式和省略的分号，输出调试信息及列表形式 AST，不会执行函数调用。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S optional-semicolon -B build/optional-semicolon
cmake --build build/optional-semicolon
```

The executable is `build/optional-semicolon/optional-semicolon`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/optional-semicolon/optional-semicolon`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`parser.y` contains `yyfilter`; `bison.m4` injects it into the parser. `sliplist.c/.h` and `list.h` supply AST/list helpers; `lexer.l` preserves newlines. / `parser.y` 中的 `yyfilter` 由 `bison.m4` 注入；列表文件提供 AST，词法文件保留换行。

## Notes / 注意事项

The custom skeleton accesses generated parser internals and may need changes across Bison versions. Generate from this directory so `./bison.m4` resolves. GCC 14 reports undeclared `fileno` under strict C11 and a call to `yyfilter` before its declaration. Defining `_POSIX_C_SOURCE=200809L` addresses only the former; the parser declaration still needs repair. The entry point assumes a filename argument. / 定制 skeleton 依赖生成器内部实现，跨版本可能需要适配；请在本目录生成以找到 `./bison.m4`。GCC 14 严格 C11 下会报 `fileno` 未声明以及 `yyfilter` 在声明前被调用；定义 `_POSIX_C_SOURCE=200809L` 只能解决前者，仍需修复解析器声明；入口未检查文件名参数是否缺失。

[All examples / 所有示例](../README.md)
