---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、脚手架、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家（Claude Code 入口）

将此 skill 作为 Claude Code 处理 Kingscript 工作的入口。

## 优先阅读

1. 阅读 `./references/examples/` 中最相关的示例
2. 如果需要插件骨架，阅读 `./references/templates/`
3. 如果涉及 SDK，先阅读 `./references/sdk/README.md`、`./references/sdk/strategy.md` 和 `./references/sdk/indexes/`
4. 如果涉及语法或关键字，阅读 `./references/language/kingscript/README.md`
5. 如果仓库内资料不足且本地挂载了外部知识盘，按 `./references/sdk/strategy.md` 进入外部扩展层，先读 `*-description.md`，需要真实写法或坑点时再读配套 `*-example.md`

## 输出约定

默认包含：

1. 场景
2. 假设
3. 代码或方案
4. 风险
5. 待确认问题

## 安全边界

- 不得编造 Kingscript API、事件名或上下文字段
- 不得假设 TypeScript 声明保证运行时可用
- 不得忽略权限、租户隔离、账套边界或生命周期时序
- 如果信息缺失，提供有边界的假设方案，而不是虚假的确定答案
- 查找 SDK 时优先走“索引 -> 目标文档”的路线，而不是整目录扫描
