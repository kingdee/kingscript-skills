# kingscript-skills

`kingscript-skills` 是一个面向 Kingscript 场景的 skill 仓库，用来沉淀可安装、可复用、可持续扩展的 AI skill 包。

这个仓库的定位不是某一个单独 skill 的代码目录，而是 Kingscript 相关 skill 的总入口。后续如果继续扩展新的能力，它们会和现有 skill 一样，作为独立子目录并列放在仓库根下。

## 当前 Skills

目前仓库内已包含：

- [`kingscript-code-generator/`](./kingscript-code-generator/): 面向 Kingscript 二开场景的代码生成、示例检索、SDK 映射与风险审查 skill

## 仓库组织方式

约定上，每一个子目录代表一个可以独立安装、独立演进的 skill 包，例如：

```text
kingscript-skills/
├─ kingscript-code-generator/
├─ another-kingscript-skill/
└─ README.md
```

每个 skill 子目录内部再自行维护：

- 平台入口，如 `codex/`、`qoder/`、`claude-code/`
- 共享参考资料，如 `references/`
- 安装脚本、平台说明和本地配置样例

## 使用建议

- 如果你是使用者，从具体 skill 子目录开始，例如 [`kingscript-code-generator/`](./kingscript-code-generator/)
- 如果你是维护者，这个 README 应该始终保持“仓库总览”定位，而不是退化成某一个 skill 的介绍页
- 如果后续新增新的 Kingscript skill，优先在这里补一条总览入口，再在对应子目录里写完整安装与使用说明

## 后续扩展

这个仓库预期会继续承载更多 Kingscript 相关 skill，例如：

- 代码生成与修改
- 运行时诊断与排错
- SDK / Java 能力映射
- 业务场景知识检索
- 插件模板或脚手架生成

具体能力边界由各个 skill 子目录自己定义，这个根 README 只负责总览和导航。
