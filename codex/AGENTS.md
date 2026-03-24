# Kingscript Codex 适配器

当任务与 Kingscript 二开有关时，优先读取：

1. `../core/docs/api-boundaries.md`
2. `../core/docs/content-map.md`
3. 与任务最接近的 `../core/examples/`

## 回答要求

- 先判断任务类型：生成、修改、排障、解释、设计、审查。
- 先补齐上下文，再给答案。
- 优先引用本仓库已有模板和示例。
- 输出中必须包含风险点和待确认项。

## 禁止事项

- 不要编造 API。
- 不要假设 Java 能力已开放。
- 不要忽略权限、租户、账套、上下文、生命周期边界。
