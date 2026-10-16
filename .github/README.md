# GitHub configuration / GitHub 配置

[`workflows/ci.yml`](workflows/ci.yml) builds and tests `modern-cpp` on every push
and pull request. It defines two Ubuntu 24.04 jobs: Make and CMake. Both run the
same 12 calculator regression cases. The workflow has read-only repository
permissions and a ten-minute timeout per job.

[`workflows/ci.yml`](workflows/ci.yml) 在 push 和 PR 时构建并测试 `modern-cpp`，
包含 Ubuntu 24.04 上的 Make、CMake 两组任务，分别执行同样的 12 组计算器回归检查。
workflow 使用只读仓库权限，每个任务限时十分钟。

It installs Flex, Bison, G++, Make, CMake, and Python 3 using apt. To run locally,
follow the [modern-cpp README](../modern-cpp/README.md). The older examples and
the documentation site are not covered by this workflow. Manual dispatch is
available once GitHub exposes the workflow on the default branch.

任务通过 apt 安装 Flex、Bison、G++、Make、CMake 和 Python 3。本地执行方法见
[modern-cpp README](../modern-cpp/README.md)。当前 CI 不覆盖旧示例或文档网站。
当默认分支包含此 workflow 后，可在 GitHub Actions 界面手动触发。
