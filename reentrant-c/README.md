# reentrant-c — Scanner context in C / C 扫描器上下文

## Overview / 简介

A minimal `function` grammar showing a reentrant Flex scanner and explicit scanner/context parameters passed into Bison.

最小的 `function` 语法，展示 Flex 可重入扫描器，以及向 Bison 显式传递扫描器和解析上下文参数。

## Requirements / 依赖

Flex, Bison, a C11 compiler, and Make or CMake 3.5+. / 需要 Flex、Bison、C11 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
printf 'function' | ./reentrant-c
```

The single `function` token is accepted without a result message. / 单个 `function` token 可被接受，不打印计算结果。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S reentrant-c -B build/reentrant-c
cmake --build build/reentrant-c
```

The executable is `build/reentrant-c/reentrant-c`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/reentrant-c/reentrant-c`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`reentrant_parser.h` defines the context; `reentrant_parser.c` initializes the scanner and calls `yyparse`; `parser.y` passes parameters; `lexer.l` matches `function`. / 上下文定义在 `reentrant_parser.h`，初始化和调用在 `reentrant_parser.c`，其余两文件定义语法及词法。

## Notes / 注意事项

The scanner is reentrant, but the grammar does not set `api.pure`, so this is not a complete thread-safe parser. Cleanup and parse-status propagation are also incomplete. With GCC 14, strict C11 reports undeclared `fileno`, and generated parser calls also lack declarations for `yylex`/`yyerror`. Defining `_POSIX_C_SOURCE=200809L` addresses only `fileno`; declarations still need repair before this toolchain can build it. / 扫描器可重入，但语法未配置 `api.pure`，不能据此认定整个解析器线程安全；资源释放和解析状态返回也未完整实现。GCC 14 严格 C11 下会报 `fileno` 以及生成代码调用的 `yylex`/`yyerror` 未声明；定义 `_POSIX_C_SOURCE=200809L` 只能解决前者，仍需补全声明才能在此工具链构建。

[All examples / 所有示例](../README.md)
