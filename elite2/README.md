# elite2 — Language grammar / 语言语法

## Overview / 简介

A larger grammar based on the author's second Elite language design. It uses
Bison's C++ parser, variant values, token constructors, locations, and a reentrant
Flex scanner. It recognizes syntax without implementing a full evaluator or compiler.

基于作者第二版 Elite 语言设计的较完整语法，使用 Bison C++ 解析器、variant、
token constructor、位置信息和 Flex 可重入扫描器；主要用于语法识别，未实现完整求值器或编译器。

## Requirements / 依赖

Flex, Bison >= 3.0.4, a C++11 compiler, and CMake 3.5+.
There is no handwritten Makefile in this directory.

需要 Flex、Bison 3.0.4+、C++11 编译器及 CMake 3.5+，本目录没有手写 Makefile。

## Build and run / 构建与运行

Run from the repository root / 从仓库根目录执行：

```sh
cmake -S elite2 -B build/elite2 -DCMAKE_CXX_STANDARD=11
cmake --build build/elite2
printf '1 + 2\n' | ./build/elite2/elite
```

The executable is named `elite`, not `elite2`. Input comes from stdin; successful
parsing does not print the value of the expression. With CMake 4, add
`-DCMAKE_POLICY_VERSION_MINIMUM=3.5` to the configure command.

可执行文件名为 `elite`，输入来自标准输入，解析成功不会输出表达式的计算结果。
使用 CMake 4 时，配置命令需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`lexer.l` defines literals, identifiers, and operators. `parser.y` defines types,
expressions, calls, and allocation syntax. `ParserCtx.hpp/.cpp` manage the scanner,
location, and parser instances.

`lexer.l` 定义字面量、标识符及运算符；`parser.y` 定义类型、表达式、调用和分配语法；
`ParserCtx.hpp/.cpp` 管理扫描器、位置和解析器实例。

## Notes / 注意事项

Bison reports shift/reduce and reduce/reduce conflicts and unused rules. This is
an exploratory grammar, so acceptance alone does not establish an unambiguous
language design. It also uses deprecated Bison configuration. For a smaller,
current C++ starting point see [modern-cpp](../modern-cpp/).

Bison 会报告移进/归约、归约/归约冲突以及未使用规则。这是探索性语法，接受输入不代表
语法无歧义；也使用了旧版 Bison 配置。较小的现代 C++ 入门示例见 [modern-cpp](../modern-cpp/)。

[All examples / 所有示例](../README.md)
