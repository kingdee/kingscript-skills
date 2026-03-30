# Kingscript Claude 适配器

此适配器通过少量命令集和共享的 `../references/` 知识库向 Claude Code 暴露 Kingscript 专业知识。

## 默认工作流

1. 分类任务：生成、修改、调试、解释、审查、设计
2. 先解析本地资源路径：优先 `local-paths.json`，其次工作区 `CLAUDE.md` / `AGENTS.md` 中声明的资源路径，最后才做默认目录发现
3. 再找 `references/examples/` 中最相关的示例
4. 如果需要插件骨架，再读 `references/templates/`
5. 如果涉及 SDK，先读 `references/sdk/README.md`、`references/sdk/strategy.md` 和 `references/sdk/indexes/`
6. 如果涉及语法、关键字或限制，再读 `references/language/kingscript/README.md`
7. 用假设、结果、风险和待确认问题来回答

## 安全边界

- 绝不编造 Kingscript API 或 Java 开放能力
- 绝不跳过租户、权限、账套或生命周期约束
- 在运行时可用性确认前，将 TypeScript 声明视为提示而非事实
- 查找 SDK 时优先使用索引，不做整目录扫描
- 当索引不足时，按 `manifests -> 本地 .d.ts -> 在线 Javadoc` 的顺序降级
