# Documentation site / 文档网站

This directory contains the GitHub Pages documentation source. It does not build
a parser executable.

本目录存放 GitHub Pages 文档网站的源文件，不生成解析器程序。

## Files / 文件

- [`index.md`](index.md): site homepage and historical example overview. / 网站首页及原有示例概览。
- [`_config.yml`](_config.yml): selects the Jekyll `jekyll-theme-slate` theme. / 配置 Jekyll 网站主题。

## Editing / 编辑

Edit Markdown directly. The [root README](../README.md) lists the examples,
including [modern-cpp](../modern-cpp/); each example directory has bilingual build
and usage instructions. `index.md` is a separate file and is not automatically
synchronized with the root README. No local Jekyll dependency manifest or site
publishing workflow is included; hosting is configured separately in repository
settings.

直接编辑 Markdown 即可。[根目录 README](../README.md) 提供示例导航，包括
[modern-cpp](../modern-cpp/)；各示例目录提供双语构建和使用说明。`index.md` 与根目录
README 是独立文件，不会自动同步。仓库未提供本地 Jekyll 依赖清单或网站发布 workflow，
网站托管需在仓库设置中单独配置。
