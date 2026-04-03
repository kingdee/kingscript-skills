---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、脚手架、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家

作为 Codex 处理 Kingscript 二开任务的入口 skill 使用。

## 本地资源发现

这个 skill 不应该把某一台机器的路径写死。每次进入 Kingscript 任务时，先按下面顺序解析本地资源根目录：

1. 优先读取 skill 同目录下的 `local-paths.json`
2. 如果没有，再读取当前工作区的 `AGENTS.md`，查找用户声明的本地资源路径
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

如果用户安装了这份 skill，只需要把这些字段改成他自己机器上的路径即可，不需要再改 `SKILL.md` 主体。

### `AGENTS.md` 约定

如果没有 `local-paths.json`，再尝试在工作区 `AGENTS.md` 里找类似下面的配置块：

```md
## Kingscript Local Resources

- `workspace_root`: `D:\kingscript skills`
- `repo_root`: `D:\kingscript skills\kingscript-code-generator`
- `references_root`: `D:\kingscript skills\kingscript-code-generator\references`
- `java_sample_jar`: `D:\kingscript skills\bos-plugin-sample-7.0.jar`
```

### 默认目录发现

只有在 `local-paths.json` 和 `AGENTS.md` 都没有提供可用路径时，才按下面顺序尝试：

1. 当前工作区下是否存在 `references/examples`、`references/sdk`、`references/templates`
2. 当前工作区的 `kingscript-code-generator/references`
3. 当前工作区的上级或同级目录里是否存在名为 `kingscript-code-generator` 的仓库副本

如果这些默认目录都不存在，就必须明确说明“本地资料根目录未配置”，而不是编造路径。

## 解析后的固定入口

### examples

- `<references_root>\examples\README.md`
- `<references_root>\examples\plugins\README.md`
- `<references_root>\examples\plugins\插件示例\`

### docs

- `<references_root>\docs\README.md`
- `<references_root>\docs\custom-development\README.md`
- `<references_root>\docs\custom-development\脚本控制器开发指南.md`

### templates

- `<templates_root>\README.md`

### sdk

- `<sdk_root>\README.md`
- `<sdk_root>\strategy.md`
- `<sdk_root>\indexes\class-index.md`
- `<sdk_root>\indexes\method-index.md`
- `<sdk_root>\indexes\methods-by-name.md`
- `<sdk_root>\indexes\scenario-index.md`
- `<sdk_root>\indexes\keyword-index.md`

### language

- `<language_root>\README.md`

## 优先阅读

1. 先解析 `references_root / docs_root / examples_root / sdk_root / templates_root / language_root`
2. 再找 `<examples_root>` 中最接近的示例
3. 如果用户提到 `KWC`、`脚本控制器`、`controller`、`REST API`、`Web API`，先读 `<references_root>\docs\custom-development\脚本控制器开发指南.md`
4. 如果需要插件骨架或占位代码，读 `<templates_root>\README.md`
5. 如果涉及 SDK，先读 `<sdk_root>\README.md`、`strategy.md` 和 `indexes\`
6. 如果涉及语法、关键字或语言限制，读 `<language_root>\README.md`

## 降级查找顺序

当 skill 里只给了目录、没有给具体文件时，必须按下面顺序继续收敛，直到落到具体文件，而不是停在目录名上：

1. 先开该目录下的 `README.md`
2. 再看该目录下的文件名是否已经能直接定位目标
3. 如果只知道类名、方法名、事件名、插件类型，优先回到 `sdk/indexes/`
4. 如果只知道“场景”，优先回到 `examples/plugins/README.md` 和对应“场景拆分”目录的 `README.md`
5. 如果仍然不够，再在目标目录里做关键字检索
6. 索引和 examples 都不够时，再降级到 `sdk/manifests/`
7. 仍不足时，再看本地 `.d.ts`、`jar` 反编译结果或在线 Javadoc

## 目录级路径的收敛规则

### 从 examples 收敛

- 已知是插件案例时，先开 `<examples_root>\plugins\README.md`
- 再根据插件类别进入 `插件示例/表单插件-场景拆分/README.md`、`插件示例/字段控件-场景拆分/README.md`、`插件示例/控件-场景拆分/README.md`、`插件示例/单据体-场景拆分/README.md`、`插件示例/报表查询插件-场景拆分/README.md` 这类目录 README
- 只有目录名时，必须继续打开该目录里的具体 `*.md`，不能只回答“去这个目录找”

### 从 docs 收敛

- 已知是 KWC、脚本控制器、Web API、REST API 开发时，先开 `<references_root>\docs\custom-development\README.md`
- 再进入 `脚本控制器开发指南.md`
- 如果只需要某一块规则，可继续在该文档中检索 `permission`、`url`、`request`、`response`、`version` 等关键字

### 从 sdk 收敛

- 已知类名：`<sdk_root>\indexes\class-index.md`
- 已知方法名：`<sdk_root>\indexes\method-index.md`，如果没有，再看 `methods-by-name.md`
- 已知生命周期或插件类型：`<sdk_root>\indexes\plugin-index.md`、`methods-lifecycle.md`
- 已知业务词或场景词：`<sdk_root>\indexes\scenario-index.md`、`keyword-index.md`
- 找到线索后，继续打开 `<sdk_root>\classes\`、`packages\`、`plugins\`、`microservices\` 下的具体文件

### 从 language 收敛

- 语法总入口先看 `<language_root>\README.md`
- 再按主题进入 `类.md`、`方法.md`、`变量.md`、`接口.md`、`异常处理.md`、`语法示例.md`

## 本地检索方式

如果目录 README 仍然不够，必须继续做本地检索。优先级如下：

1. 优先 `rg --files` 或 `rg -n`
2. 如果 `rg` 不可用或权限异常，改用 PowerShell：

```powershell
Get-ChildItem -Path '<references_root>' -Recurse -Include *.md |
  Select-String -Pattern 'SearchEnterEvent|EntryGridBindDataEvent|AbstractReportFormPlugin' -Encoding UTF8
```

3. 如果要先看目录里有什么文件，用：

```powershell
Get-ChildItem -Path '<examples_root>\plugins\插件示例\控件-场景拆分'
```

4. 如果要从 `jar` 里找 Java 来源，用：

```powershell
jar tf '<java_sample_jar>' | Select-String 'SearchSample|TreeViewSample|ReportColumnMergePlugin'
```

## 任务路由

### 生成或修改代码

- 如果目标是 KWC 脚本控制器，先读 `<references_root>\docs\custom-development\脚本控制器开发指南.md`
- 先读 `<templates_root>\`
- 再读 `<examples_root>\` 中最相关的示例
- 生成代码时优先复用已有插件模板和事件写法
- 生成代码前，先确认每个外部类、助手类、事件类、枚举和工具类的真实 import 路径；不能只看到示例里用过就省略 import
- 最终输出代码前，必须逐个自检非全局符号是否已显式 import；不能依赖 IDE、编辑器或运行环境自动补 import
- 如果某个符号不需要 import，必须能明确说明它是运行时全局、当前文件局部定义，或由框架自动注入
- 页面提示、通知、消息框相关方法，必须回到 `IFormView` 或本地声明层确认，不把示例里出现过的方法名直接当成可用 API
- 调用 `obj.method()` 前，必须确认 `method` 属于 `obj` 当前类型或其声明继承链；不能只因为别的事件参数或上下文对象上有同名方法就直接套用
- 生成代码时不得把事件参数写成 `any`；如果当前版本声明只给出 `BizDataEventArgs` 或 `$.java.util.EventObject`，也必须按声明原样写

### 解释 SDK 或 Java 映射

- 先读 `<sdk_root>\README.md`
- 再读 `<sdk_root>\strategy.md`
- 已知类名时优先读 `<sdk_root>\indexes\class-index.md`
- 已知方法名时优先读 `<sdk_root>\indexes\method-index.md`；未命中时补读 `methods-by-name.md`
- 只知道场景时优先读 `<sdk_root>\indexes\scenario-index.md`
- 只知道关键词时优先读 `<sdk_root>\indexes\keyword-index.md`
- 找到入口后，再读 `<sdk_root>\classes\`、`packages\`、`plugins\`、`microservices\` 下的具体文件
- 索引不足时，再降级到 `<sdk_root>\manifests\`
- 如果维护者本地额外挂载了外部知识盘，再按 `strategy.md` 进入外部扩展层
- 如果 `local-paths.json` 中配置了 `bos_docs_path`，把它视为外部知识盘主入口；只有仓库内资料不足时才进入
- 命中外部 `*-description.md` 时，先读描述卡；只有需要真实写法、坑点或运行时边界时，再继续读配套 `*-example.md`
- 仍不足时，再读取本地最相关的 `.d.ts` 或在线 Javadoc

### 诊断问题或做风险审查

- 如果问题发生在 KWC controller、接口路由、权限配置、请求响应处理上，先读 `<references_root>\docs\custom-development\脚本控制器开发指南.md`
- 先找同类场景的 `<examples_root>\`
- 再核对 `<sdk_root>\` 中的类、方法和生命周期说明
- 最后核对 `<language_root>\README.md` 及相关语法条目

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
