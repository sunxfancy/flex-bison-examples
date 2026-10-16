# reentrant-variant-cpp — C++ parser and variants / C++ 解析器与 variant

## Overview / 简介

A minimal Bison `lalr1.cc` parser with variant semantic storage, token constructors, locations, and an instance-owned reentrant Flex scanner.

最小 Bison `lalr1.cc` 示例，展示 variant 语义值、token constructor、位置信息，以及由实例持有的 Flex 可重入扫描器。

## Requirements / 依赖

Flex, Bison >= 3.0.4, a C++11 compiler, and Make or CMake 3.5+. / 需要 Flex、Bison 3.0.4+、C++11 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
printf 'function\n' | ./reentrant-variant-cpp
```

Accepts `function` followed by whitespace and EOF, without a result message. The grammar is a scaffold, not a full language. / 接受 `function`、空白及文件结束，无结果输出；这是扩展语法的骨架。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S reentrant-variant-cpp -B build/reentrant-variant-cpp
cmake --build build/reentrant-variant-cpp
```

The executable is `build/reentrant-variant-cpp/reentrant-variant-cpp`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/reentrant-variant-cpp/reentrant-variant-cpp`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`ParserCtx.hpp/.cpp` own scanner, location, and parser lifetimes. `parser.y` configures the C++ API; `lexer.l` returns constructed tokens. / `ParserCtx.hpp/.cpp` 管理扫描器、位置和解析器生命周期；语法和词法文件配置 C++ 接口并返回构造后的 token。

## Notes / 注意事项

Uses deprecated `%name-prefix` and verbose errors. Location tracking is basic. For Bison 3.8 detailed errors and LAC see [modern-cpp](../modern-cpp/). / 使用旧的 `%name-prefix` 和 verbose 错误配置，位置跟踪较基础；Bison 3.8 的详细错误及 LAC 请看 [modern-cpp](../modern-cpp/)。

[All examples / 所有示例](../README.md)
