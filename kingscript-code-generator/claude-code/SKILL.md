---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、脚手架、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家（Claude Code 入口）

将此 skill 作为 Claude Code 处理 Kingscript 工作的入口。

## 本地资源发现

这个 skill 不应该把某一台机器的路径写死。每次进入 Kingscript 任务时，先按下面顺序解析本地资源根目录：

1. 优先读取 skill 同目录下的 `local-paths.json`
2. 如果没有，再读取当前工作区的 `CLAUDE.md`、`AGENTS.md` 或同类本地说明文件，查找用户声明的本地资源路径
3. 如果还没有，再尝试默认目录发现

只有在上一步路径真实存在时，才允许继续使用；不存在就继续降级，不要直接假设目录一定在。

### `local-paths.json` 约定

文件位置：

- skill 安装目录下的 `local-paths.json`

建议字段：

- `workspace_root`
- `repo_root`
- `references_root`
- `docs_root`
- `examples_root`
- `sdk_root`
- `templates_root`
- `language_root`
- `java_sample_jar`
- `bos_docs_path`

### 默认目录发现

只有在 `local-paths.json` 和工作区说明文件都没有提供可用路径时，才按下面顺序尝试：

1. 当前工作区下是否存在 `references/examples`、`references/sdk`、`references/templates`
2. 当前工作区的 `kingscript-code-generator/references`
3. 当前工作区的上级或同级目录里是否存在名为 `kingscript-code-generator` 的仓库副本

## 优先阅读

1. 先解析 `references_root / docs_root / examples_root / sdk_root / templates_root / language_root`
2. 如果用户提到 `KWC`、`脚本控制器`、`controller`、`REST API`、`Web API`，先阅读 `<references_root>\docs\custom-development\脚本控制器开发指南.md`
3. 阅读 `<examples_root>` 中最相关的示例
4. 如果需要插件骨架，阅读 `<templates_root>`
5. 如果涉及 SDK，先阅读 `<sdk_root>\README.md`、`<sdk_root>\strategy.md` 和 `<sdk_root>\indexes\`
6. 如果涉及语法或关键字，阅读 `<language_root>\README.md`
7. 如果仓库内资料不足且本地挂载了外部知识盘，按 `<sdk_root>\strategy.md` 进入外部扩展层，先读 `*-description.md`，需要真实写法或坑点时再读配套 `*-example.md`
8. 如果 `local-paths.json` 中配置了 `bos_docs_path`，把它视为外部知识盘主入口；只有仓库内资料不足时才进入

## 降级查找顺序

1. 先开目标目录下的 `README.md`
2. 再看文件名是否已能直接定位
3. 只知道类名、方法名、事件名时，优先回到 `<sdk_root>\indexes\`
4. 只知道场景时，优先回到 `<examples_root>\plugins\README.md` 和对应“场景拆分”目录 README
5. 如果仍然不够，再对 `<references_root>` 做关键字检索
6. 索引和 examples 都不够时，再降级到 `<sdk_root>\manifests\`
7. 仍不足时，再看本地 `.d.ts`、`jar` 反编译结果或在线 Javadoc

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
- 生成代码前必须确认每个外部类、助手类、事件类、枚举和工具类的真实 import 路径
- 最终输出代码前必须自检所有非全局符号都已显式 import，不能依赖 IDE 或编辑器自动补全
- 如果某个符号不需要 import，必须能说明它是运行时全局、当前文件局部定义，或由框架自动注入
- 如果信息缺失，提供有边界的假设方案，而不是虚假的确定答案
- 查找 SDK 时优先走“索引 -> 目标文档”的路线，而不是整目录扫描
- 页面提示、通知、消息框相关方法，必须回到 `IFormView` 或本地声明层确认
- 调用 `obj.method()` 前，必须确认 `method` 属于 `obj` 当前类型或其声明继承链，不能把相邻事件参数或上下文对象的方法混用
- 不允许按“近似名字”猜方法；例如声明里是 `addItemClickListeners(...)`，就不能擅自写成 `addItemClickService(...)`
- 生成代码时不得把事件参数写成 `any`；如果声明层只给出 `BizDataEventArgs` 或 `$.java.util.EventObject`，也必须按声明原样使用
- 当用户指出示例、模板或生成代码存在错误时，不能只修当前片段；还要判断这个问题是否应沉淀成可复用约束，并按影响范围回写到平台入口、策略、知识卡、索引、模板或示例入口，避免同类问题重复生成
