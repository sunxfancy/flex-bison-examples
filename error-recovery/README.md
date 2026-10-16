# error-recovery — Recover at statement boundaries / 在语句边界恢复

## Overview / 简介

A calculator demonstrating Bison’s `error` token and `yyerrok`. A malformed expression is skipped through `=` plus newline, so later expressions can still be parsed.

通过 Bison 的 `error` token 和 `yyerrok` 展示恢复：错误表达式跳过至 `=` 加换行，随后继续解析后面的表达式。

## Requirements / 依赖

Flex, Bison, a C++ compiler, and Make or CMake 3.5+. / 需要 Flex、Bison、C++ 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
./error-recovery test.txt
```

The bundled file mixes valid and invalid expressions. Expect numeric results interleaved with syntax diagnostics. You can also pipe stdin. / 自带文件混合合法和错误表达式，输出包含计算结果和语法错误；也可从标准输入读取。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S error-recovery -B build/error-recovery
cmake --build build/error-recovery
```

The executable is `build/error-recovery/error-recovery`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/error-recovery/error-recovery`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`parser.y`: compare `exp EQUAL END` with `error EQUAL END`. `lexer.l` returns the boundary tokens; `test.txt` exercises recovery. / 重点比较 `parser.y` 中两条语句规则；`lexer.l` 返回同步边界 token，`test.txt` 演示恢复。

## Notes / 注意事项

Recovery is at `=` plus newline, not at every newline. Lexical errors still exit immediately, and main returns zero after parser errors. Division by zero is reported separately by an action. / 恢复边界是 `=` 加换行，并非任意换行；词法错误仍直接退出，主函数也未返回解析错误状态。除零由语义动作单独报告。

[All examples / 所有示例](../README.md)
