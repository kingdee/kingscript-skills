---
name: kingscript-expert
description: "用于处理 Claude Code 中的 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的核心引用，不编造不可用的 API。"
---

# Kingscript 专家（Claude Code 入口）

将此 skill 作为 Claude Code 处理 Kingscript 工作的入口。

## 优先阅读

1. 阅读 `./core/docs/api-boundaries.md`
2. 阅读 `./core/docs/content-map.md`
3. 如果涉及 SDK，先阅读 `./core/sdk/README.md`、`./core/sdk/strategy.md` 和 `./core/sdk/indexes/`
4. 阅读 `./core/templates/` 中最相关的模板
5. 阅读 `./core/examples/` 或 `./core/recipes/` 中最相关的示例或配方

## 输出约定

默认包含：

1. 场景
2. 假设
3. 代码或方案
4. 风险
5. 待确认问题

## 安全边界

- 不得编造 Kingscript API、事件名或上下文字段。
- 不得假设 TypeScript 声明保证运行时可用。
- 不得忽略权限、租户隔离、账套边界或生命周期时序。
- 如果所需信息缺失，提供有界的假设方案，而非虚假确定答案。
- 查找 SDK 时优先走“索引 -> 目标文档”的路线，而不是整目录扫描。
- 当知识卡和索引不足时，继续按 `manifests -> 本地 .d.ts -> 在线 Javadoc` 的顺序降级。
