---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享示例、模板、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家（Qoder 适配版）

这个入口把 Qoder 场景下最常用的检索顺序和输出约束集中到一个文件里，避免在平台侧缺少额外引导文件时走偏。

## 本地资源发现

这个 skill 不应该把某一台机器的路径写死。每次进入 Kingscript 任务时，先按下面顺序解析本地资源根目录：

1. 优先读取 skill 同目录下的 `local-paths.json`
2. 如果没有，再读取当前工作区的 `AGENTS.md` 或同类本地说明文件，查找用户声明的本地资源路径
3. 如果还没有，再尝试默认目录发现

只有在上一步路径真实存在时，才允许继续使用；不存在就继续降级，不要直接假设目录一定在。

### `local-paths.json` 约定

文件位置：

- skill 安装目录下的 `local-paths.json`

建议字段：

- `workspace_root`
- `repo_root`
- `references_root`
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

## 解析后的固定入口

- `<examples_root>\README.md`
- `<examples_root>\plugins\README.md`
- `<templates_root>\README.md`
- `<sdk_root>\README.md`
- `<sdk_root>\strategy.md`
- `<sdk_root>\indexes\class-index.md`
- `<sdk_root>\indexes\method-index.md`
- `<sdk_root>\indexes\methods-by-name.md`
- `<sdk_root>\indexes\scenario-index.md`
- `<sdk_root>\indexes\keyword-index.md`
- `<language_root>\README.md`

## 推荐检索顺序

1. 先解析 `references_root / examples_root / sdk_root / templates_root / language_root`
2. 先看最接近的代码示例：`<examples_root>`
3. 需要起手骨架时看：`<templates_root>\README.md`
4. 涉及 SDK 语义时看：`<sdk_root>\README.md`、`<sdk_root>\indexes\`
5. 涉及语法、关键字和命名规则时看：`<language_root>\README.md`

## 降级查找顺序

1. 先开目标目录下的 `README.md`
2. 再看文件名是否已能直接定位
3. 只知道类名、方法名、事件名时，优先回到 `<sdk_root>\indexes\`
4. 只知道场景时，优先回到 `<examples_root>\plugins\README.md` 和对应“场景拆分”目录 README
5. 如果仍然不够，再对 `<references_root>` 做关键字检索
6. 索引和 examples 都不够时，再降级到 `<sdk_root>\manifests\`
7. 仍不足时，再看本地 `.d.ts`、`jar` 反编译结果或在线 Javadoc

## 本地检索方式

1. 优先 `rg --files` 或 `rg -n`
2. 如果 `rg` 不可用或权限异常，改用 PowerShell：

```powershell
Get-ChildItem -Path '<references_root>' -Recurse -Include *.md |
  Select-String -Pattern 'SearchEnterEvent|EntryGridBindDataEvent|AbstractReportFormPlugin' -Encoding UTF8
```

3. 如果要从 `jar` 里找 Java 来源，用：

```powershell
jar tf '<java_sample_jar>' | Select-String 'SearchSample|TreeViewSample|ReportColumnMergePlugin'
```

## Qoder 下的任务路由

- 用户问“这段代码怎么写”：先去 `<examples_root>`
- 用户问“这个类/事件是什么”：先去 `<sdk_root>\classes\` 或 `<sdk_root>\packages\`
- 用户问“我该从哪个插件起手”：先去 `<templates_root>`
- 用户贴错误或异常：先去 `<sdk_root>\indexes\error-index.md`
- 仓库内资料不足且本地挂载了外部知识盘时：按 `<sdk_root>\strategy.md` 进入外部扩展层，先读 `*-description.md`，需要代码和坑点时再读 `*-example.md`
- 如果 `local-paths.json` 中配置了 `bos_docs_path`，把它视为外部知识盘主入口；只有仓库内资料不足时才进入

## 输出规则

- 先说明场景，再给代码或结论。
- 代码前先声明关键假设。
- 必须指出风险点和待确认项。
- 优先复用本 skill 里的示例和模板，不凭空发明 API。
- 本地知识不够时，按 `indexes -> classes/packages -> manifests -> 外部知识盘(可选) -> 本地 .d.ts -> 在线 Javadoc` 降级。
- 页面提示、通知、消息框相关方法，先回到 `IFormView` 或本地声明层确认，再决定是否可用。
- 调用 `obj.method()` 前，必须确认 `method` 属于 `obj` 当前类型或其声明继承链，不能把别的事件参数或上下文对象的方法直接套过来。
- 生成代码时不得把事件参数写成 `any`；如果当前版本声明只给出 `BizDataEventArgs` 或 `$.java.util.EventObject`，也要按声明原样输出。

## 禁止事项

- 不编造 Kingscript API、事件名或上下文对象。
- 不默认假设 Java 开放能力一定可用。
- 不忽略权限、组织、租户、账套和生命周期边界。
