# simple-cpp — C API with C++ / 在 C 接口中使用 C++

## Overview / 简介

The simple calculator compiled as C++11. Shows a `Data*` semantic value in `%union` and `%code requires` for a forward declaration. It still uses the C parser API and globals.

将基础计算器编译为 C++11，展示 `%union` 中的 `Data*` 和 `%code requires` 前向声明；仍使用 C 解析接口及全局状态。

## Requirements / 依赖

Flex, Bison, a C++11 compiler, and Make or CMake 3.5+. / 需要 Flex、Bison、C++11 编译器及 Make 或 CMake 3.5+。

## Build and run / 构建与运行

Run from this directory / 在本目录执行：

```sh
make
printf '1 + 2 * 3 =\n-(4 + 2) =\n' | ./simple-cpp
```

Prints `7.000000` and `-6.000000`. Each expression requires `=` and newline; a filename argument is also accepted. / 输出 `7.000000` 和 `-6.000000`；表达式须以 `=` 和换行结尾，也支持文件名参数。

Alternative standalone CMake build, from the repository root / 也可从仓库根目录独立构建：

```sh
cmake -S simple-cpp -B build/simple-cpp
cmake --build build/simple-cpp
```

The executable is `build/simple-cpp/simple-cpp`; pass the same input as above. With CMake 4, add `-DCMAKE_POLICY_VERSION_MINIMUM=3.5` when configuring these legacy projects. / 可执行文件为 `build/simple-cpp/simple-cpp`，输入方式同上；CMake 4 配置旧项目时需加 `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`。

## Code guide / 代码导读

`lexer.l` supplies tokens; `parser.y` defines `Data`, the union, grammar, and main function. / `lexer.l` 提供 token；`parser.y` 定义 `Data`、union、语法和主函数。

## Notes / 注意事项

This is not the Bison C++ class API. Ownership of example semantic objects is incomplete, and error paths may return zero. For a modern starting point see [modern-cpp](../modern-cpp/). / 此例不是 Bison 的 C++ 类接口，示例对象的资源管理不完整，错误路径也可能返回 0；现代写法请看 [modern-cpp](../modern-cpp/)。

[All examples / 所有示例](../README.md)
