# Kingscript Codex 适配器

当任务与 Kingscript 二开有关时，优先读取：

1. `../references/examples/` 中最相关的示例
2. `../references/templates/README.md`
3. 如果涉及 SDK，再读 `../references/sdk/README.md`、`../references/sdk/strategy.md` 和 `../references/sdk/indexes/`
4. 如果涉及语法或关键字，再读 `../references/language/kingscript/README.md`

## 回答要求

- 优先复用仓库里的示例、脚手架和 SDK 索引
- 先说明场景和假设，再给代码或结论
- 必须指出风险点和待确认项
- 如果本地资料不足，明确说明缺口，不编造 API

## 禁止事项

- 不要编造 Kingscript API、事件名或上下文对象
- 不要假设 Java 开放能力一定可用
- 不要忽略权限、租户、组织、账套或生命周期边界
