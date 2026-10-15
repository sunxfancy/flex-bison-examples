# simple-c — C calculator / C 计算器

## Overview / 简介

A beginner calculator using the C parser API, global scanner/parser state, `%union`, and precedence rules. Each expression ends with `=` and a newline.

入门 C 计算器，展示全局扫描/解析状态、`%union` 和运算优先级。每个表达式以 `=` 加换行结束。

## Requirements / 依赖

Flex, Bison, a C11 compiler, and Make; CMake 3.5+ is an alternative. / 需要 Flex、Bison、C11 编译器及 Make，也可使用 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
printf '1 + 2 * 3 =\n-(4 + 2) =\n' | ./simple-c
```

Prints `7.000000` and `-6.000000` (with leading whitespace). An optional filename argument replaces stdin. / 输出 `7.000000` 和 `-6.000000`（带前导空白）；可传入文件名替代标准输入。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S simple-c -B build/simple-c
cmake --build build/simple-c
```

The executable is `build/simple-c/simple-c`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/simple-c/simple-c`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`lexer.l` recognizes numbers/operators; `parser.y` contains the grammar, semantic values, and entry point. / `lexer.l` 定义数字和运算符，`parser.y` 包含语法、语义值和入口。

## Notes / 注意事项

The legacy Makefile uses strict C11: GCC 14 reports an undeclared `fileno` in generated Flex code. On POSIX systems try `make OPT="-O3 -std=c11 -D_POSIX_C_SOURCE=200809L"`. Error paths can return zero; this is a teaching example, not a reliable validation CLI. / 旧 Makefile 使用严格 C11，GCC 14 会因 Flex 生成代码未声明 `fileno` 而失败；POSIX 系统可尝试上述命令。错误路径可能返回 0，不能仅用退出码判断解析成功。

[All examples / 所有示例](../README.md)
