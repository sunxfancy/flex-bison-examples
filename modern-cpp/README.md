# Modern C++ calculator / 现代 C++ 示例

Requires Flex >= 2.6.4, Bison >= 3.8 (tested with 3.8.2), a C++17 compiler,
and Make or CMake >= 3.16. These version requirements apply to this example;
older examples retain their existing requirements.

需要 Flex 2.6.4、Bison 3.8+ 和 C++17。此示例演示可重入扫描器、RAII 资源释放、
variant 语义值、token constructor、位置跟踪，以及 detailed + LAC 精确语法错误提示。
`api.namespace` 替代旧的 `name-prefix`，不依赖全局解析状态。
Bison 的 variant 是其生成器提供的类型容器，并非 `std::variant`。

```sh
cd modern-cpp
make -j
printf '1 + 2 * 3\n-(4 + 2) / 2\n' | ./build/modern-cpp
# 7
# -3
```

Or build independently with CMake / 也可以独立使用 CMake：

```sh
cmake -S modern-cpp -B build/modern-cpp
cmake --build build/modern-cpp --parallel
printf '1 + 2 * 3\n' | ./build/modern-cpp/modern-cpp
```

Each expression must end with a newline (LF or CRLF); blank lines are allowed.
Supports decimal numbers, parentheses, unary minus, and `+ - * /`.
Invalid characters, syntax errors, and division by zero print a location to stderr
and return a nonzero exit code. This example stops at the first error;
see `error-recovery` for recovery across multiple lines.

每个表达式以换行结束，支持空行、小数、括号和一元负号。错误时输出行列位置并返回失败；
此例在首个错误处停止，多行错误恢复请参照 `error-recovery`。

```sh
printf '1 + )\n' | ./build/modern-cpp
# 1.5: syntax error, unexpected ) ...
printf '1 / 0\n' | ./build/modern-cpp
# 1.5: division by zero
```

## Automated tests / 自动测试

```sh
python3 modern-cpp/test.py modern-cpp/build/modern-cpp
```

Run this command from the repository root after either build above (for the
standalone CMake path, pass `build/modern-cpp/modern-cpp` instead).
Tests check results, exit codes, and diagnostics for valid and invalid input.
GitHub Actions runs both Make and CMake on Ubuntu 24.04 for pushes and
pull requests; it can also be triggered manually.

在仓库根目录执行上述命令；若按前面的 CMake 路径构建，则传入
`build/modern-cpp/modern-cpp`。CI 在 Ubuntu 24.04 上分别构建并测试两种构建方式，
覆盖运算优先级、小数、换行格式、错误位置、除零及不完整输入。
