# Workflows / 自动化工作流

[`ci.yml`](ci.yml) is the calculator CI workflow: two Ubuntu 24.04 jobs build
`modern-cpp` with Make and CMake, then run its Python regression tests. It runs
on pushes and pull requests and declares a manual dispatch trigger.

[`ci.yml`](ci.yml) 是计算器 CI：在 Ubuntu 24.04 上用 Make 和 CMake 分别构建
`modern-cpp`，随后执行 Python 回归测试。由 push、PR 触发，也声明了手动触发入口。

See [GitHub configuration](../README.md) for permissions and scope, and
[the example README](../../modern-cpp/README.md) for local commands.

权限及覆盖范围见 [GitHub 配置](../README.md)，本地命令见
[示例说明](../../modern-cpp/README.md)。
