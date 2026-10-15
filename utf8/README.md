# utf8 — UTF-8 tokens / UTF-8 词法匹配

## Overview / 简介

Demonstrates matching UTF-8 byte sequences with Flex, using the Chinese keyword `类型`, non-ASCII identifiers, numbers, and quoted strings.

展示用 Flex 匹配 UTF-8 字节序列，使用中文关键字 `类型`、非 ASCII 标识符、数字和字符串。

## Requirements / 依赖

Flex, Bison, a C compiler, Make or CMake 3.5+, and UTF-8 input/terminal. / 需要 Flex、Bison、C 编译器、Make 或 CMake 3.5+，输入和终端使用 UTF-8。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
./utf8 test.txt
```

The sample declares `速度 = 12` and `文本 = "flex中文支持"` after `类型`; output shows their names, kinds, and values. Each declaration ends with newline. / 示例以 `类型` 声明速度和文本，输出名称、类型和值；声明以换行结束。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S utf8 -B build/utf8
cmake --build build/utf8
```

The executable is `build/utf8/utf8`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/utf8/utf8`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`lexer.l` defines multibyte patterns and copies token text; `parser.y` recognizes numeric/string declarations; `test.txt` supplies UTF-8 input. / `lexer.l` 定义多字节模式及文本复制，`parser.y` 识别数字和字符串声明，`test.txt` 提供 UTF-8 输入。

## Notes / 注意事项

This is byte-pattern matching, not full Unicode identifier classification, normalization, or validation. ASCII identifiers are not matched by the ID rule. The Makefile passes a C++ standard flag to a C compiler, which can warn; `make OPT=-O3` avoids that flag. / 此例不是完整的 Unicode 标识符分类、规范化或校验；ID 规则不匹配 ASCII 名称。Makefile 将 C++ 标准参数传给 C 编译器，可能产生警告，可用 `make OPT=-O3`。

[All examples / 所有示例](../README.md)
