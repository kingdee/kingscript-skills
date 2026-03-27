---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、脚手架、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家

作为 Codex 处理 Kingscript 二开任务的入口 skill 使用。

## 优先阅读

1. 先找 `../references/examples/` 中最接近的示例
2. 如果需要插件骨架或占位代码，读 `../references/templates/README.md`
3. 如果涉及 SDK，先读 `../references/sdk/README.md`、`../references/sdk/strategy.md` 和 `../references/sdk/indexes/`
4. 如果涉及语法、关键字或语言限制，读 `../references/language/kingscript/README.md`

## 任务路由

### 生成或修改代码

- 先读 `../references/templates/`
- 再读 `../references/examples/` 中最相关的示例
- 生成代码时优先复用已有插件模板和事件写法

### 解释 SDK 或 Java 映射

- 先读 `../references/sdk/README.md`
- 再读 `../references/sdk/strategy.md`
- 已知类名时优先读 `../references/sdk/indexes/class-index.md`
- 已知方法名时优先读 `../references/sdk/indexes/method-index.md`
- 只知道场景时优先读 `../references/sdk/indexes/scenario-index.md`
- 只知道关键词时优先读 `../references/sdk/indexes/keyword-index.md`
- 找到入口后，再读 `../references/sdk/classes/`、`../references/sdk/packages/`、`../references/sdk/plugins/`、`../references/sdk/microservices/`
- 索引不足时，再降级到 `../references/sdk/manifests/`
- 如果维护者本地额外挂载了外部知识盘，再按 `strategy.md` 进入外部扩展层
- 命中外部 `*-description.md` 时，先读描述卡；只有需要真实写法、坑点或运行时边界时，再继续读配套 `*-example.md`
- 仍不足时，再读取本地最相关的 `.d.ts` 或在线 Javadoc

### 诊断问题或做风险审查

- 先找同类场景的 `../references/examples/`
- 再核对 `../references/sdk/` 中的类、方法和生命周期说明
- 最后核对 `../references/language/kingscript/README.md` 及相关语法条目

## 输出约定

默认采用结构化回答，包含：

1. 场景
2. 假设
3. 代码或方案
4. 风险
5. 待确认问题

## 不可违背的规则

- 不得编造 Kingscript API、事件名或上下文对象结构
- 不得假设 TypeScript 声明保证运行时可用
- 不得忽略权限、租户隔离或生命周期时序
- 如果信息缺失，提供有边界的假设方案，而不是虚假的确定答案
