---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享示例、模板、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家（Qoder 适配版）

这个入口把 Qoder 场景下最常用的检索顺序和输出约束集中到一个文件里，避免在平台侧缺少额外引导文件时走偏。

## 推荐检索顺序

1. 先看最接近的代码示例：`../references/examples/`
2. 需要起手骨架时看：`../references/templates/README.md`
3. 涉及 SDK 语义时看：`../references/sdk/README.md`、`../references/sdk/indexes/`
4. 涉及语法、关键字和命名规则时看：`../references/language/kingscript/README.md`

## Qoder 下的任务路由

- 用户问“这段代码怎么写”：先去 `examples/`
- 用户问“这个类/事件是什么”：先去 `sdk/classes/` 或 `sdk/packages/`
- 用户问“我该从哪个插件起手”：先去 `templates/`
- 用户贴错误或异常：先去 `sdk/indexes/error-index.md`
- 仓库内资料不足且本地挂载了外部知识盘时：按 `references/sdk/strategy.md` 进入外部扩展层，先读 `*-description.md`，需要代码和坑点时再读 `*-example.md`

## 输出规则

- 先说明场景，再给代码或结论。
- 代码前先声明关键假设。
- 必须指出风险点和待确认项。
- 优先复用本 skill 里的示例和模板，不凭空发明 API。
- 本地知识不够时，按 `indexes -> classes/packages -> manifests -> 外部知识盘(可选) -> 本地 .d.ts -> 在线 Javadoc` 降级。

## 禁止事项

- 不编造 Kingscript API、事件名或上下文对象。
- 不默认假设 Java 开放能力一定可用。
- 不忽略权限、组织、租户、账套和生命周期边界。
