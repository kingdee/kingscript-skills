# Kingscript Claude 适配器

此适配器通过少量命令集和共享的 `../core/` 知识库向 Claude Code 暴露 Kingscript 专业知识。

## 默认工作流

1. 阅读 `../core/docs/api-boundaries.md`
2. 分类任务：生成、修改、调试、解释、审查、设计
3. 如果涉及 SDK，先阅读 `../core/sdk/README.md`、`../core/sdk/strategy.md` 与 `../core/sdk/indexes/`
4. 从 `../core/templates/` 读取匹配的模板
5. 从 `../core/examples/` 或 `../core/recipes/` 读取最相关的示例或配方
6. 用假设、结果、风险和待确认问题来回答

## 安全边界

- 绝不编造 Kingscript API 或 Java 开放能力。
- 绝不跳过租户、权限、账套或生命周期约束。
- 在运行时可用性确认前，将 TypeScript 声明视为提示而非事实。
- 查找 SDK 时优先使用索引，不整目录扫描。
- 当知识卡和索引不足时，按 `manifests -> 本地 .d.ts -> 在线 Javadoc` 的顺序降级。
