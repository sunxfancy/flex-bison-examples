# python-like-indentation — Indentation-sensitive grammar / 缩进语法

## Overview / 简介

Extends the optional-semicolon approach with Flex start conditions, indentation tracking, and `INDENT`/`DEDENT` tokens. Incomplete expressions can continue across lines.

在可选分号基础上，利用 Flex start condition、缩进跟踪和 `INDENT`/`DEDENT` 实现缩进语法，并允许未完成表达式跨行。

## Requirements / 依赖

Flex, Bison compatible with the bundled custom skeleton, a C compiler, and Make or CMake 3.5+. / 需要 Flex、兼容定制 skeleton 的 Bison、C 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
./python-like-indentation test.txt
```

Pass the sample filename. It uses `defun` and indentation (not Python’s exact syntax); output traces scanning/parsing and prints a list-based AST. / 传入示例文件名，使用 `defun` 和缩进，并非完整 Python 语法；输出扫描/解析跟踪及列表 AST。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S python-like-indentation -B build/python-like-indentation
cmake --build build/python-like-indentation
```

The executable is `build/python-like-indentation/python-like-indentation`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/python-like-indentation/python-like-indentation`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`lexer.l` tracks indentation and start conditions; `parser.y` probes legal tokens; `bison.m4` calls the filter; `sliplist.c/.h` and `list.h` implement AST helpers. / 词法文件跟踪缩进及状态，语法文件探测合法 token，定制 skeleton 调用过滤器，列表文件实现 AST。

## Notes / 注意事项

This legacy example currently fails to build with GCC 14 because generated code calls `yyfilter` before it is declared. Its Makefile also uses a C++ standard flag for C. These issues are recorded here, not fixed by this documentation change. Run generation from this directory to locate `./bison.m4`. Tabs use four-column stops; this is not a Python-compatible parser. / 此旧例在 GCC 14 下因生成代码在声明前调用 `yyfilter` 而构建失败；Makefile 还将 C++ 标准参数用于 C。本次文档改动记录问题，未修改实现。请在本目录生成以找到 skeleton；制表符按四列对齐，不是兼容 Python 的解析器。

[All examples / 所有示例](../README.md)
