# error-handling — Source-aware diagnostics / 带源码位置的错误提示

## Overview / 简介

Christian Hagen’s IBM developerWorks calculator example, with variables, custom input buffering, source-line display, token markers, and formatted diagnostics.

Christian Hagen 的 IBM developerWorks 计算器示例，展示变量、自定义输入缓冲、源码行显示、token 标记及格式化错误提示。

## Requirements / 依赖

Flex, Bison, a C compiler, and Make. This directory has no CMake target and is not in the root CMake build. / 需要 Flex、Bison、C 编译器及 Make；本目录没有 CMake 目标，也未加入根目录 CMake 构建。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
./ccalc defs.txt
./ccalc -debug defs.txt
```

Without an argument, `ccalc` reads `defs.txt`. The bundled file intentionally contains errors; expect source markers and a final variable dump. Statements end with semicolons. / 不传参数时读取 `defs.txt`；自带文件故意包含错误，输出位置标记及最终变量表；语句用分号结束。

## Code guide / 代码导读

`ccalc.c/.h` handle source input and diagnostics; `cmath.c` manages variables and evaluation; `lex.l` and `parse.y` define the language; `defs.txt` exercises errors. / `ccalc.c/.h` 处理源码和错误，`cmath.c` 管理变量和计算，其余文件定义语言及测试输入。

## Notes / 注意事项

This is a historical reference with global state, not a reentrant implementation. Preserve the author attribution in source files. See the [original article](https://developer.ibm.com/tutorials/l-flexbison/). / 此历史示例使用全局状态，不可重入；请保留源文件作者署名，参阅[原文](https://developer.ibm.com/tutorials/l-flexbison/)。

[All examples / 所有示例](../README.md)
