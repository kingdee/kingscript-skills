---
name: kingscript-expert
description: "用于解决 Kingscript 定制化任务，包括脚本编写、脚本修改、SDK 解释、Java 桥接映射、运行时排障、实现设计或代码审查。优先复用共享核心知识库，保持假设明确，不编造不可用的 API。"
---

# Kingscript 专家（Qoder 适配版）

此适配器复用共享的 `../core/` 知识库。

## 建议阅读顺序

1. `../core/docs/content-map.md`
2. `../core/docs/api-boundaries.md`
3. 如果是 SDK 问题，先读 `../core/sdk/README.md`、`../core/sdk/strategy.md` 和 `../core/sdk/indexes/`
4. `../core/templates/` 中最相关的模板
5. `../core/examples/` 中最相关的示例

## 输出规则

- 先解释场景。
- 代码前先声明假设。
- 指出风险和未确认项。
- 优先使用示例而非自由发挥。
- 解释 SDK 时，优先走“索引 -> 目标类/包/场景文档”的路线，不要整目录扫描。
- 如果知识卡与索引不足，再降级到 `manifests -> 本地 .d.ts -> 在线 Javadoc`。
