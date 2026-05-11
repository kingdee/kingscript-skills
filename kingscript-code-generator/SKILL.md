---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、模板、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家

作为 AI Agent 处理 Kingscript 二开任务的入口 skill 使用。

## 目录结构

```
./
├── SKILL.md                                    ← 本文件（通用 skill 入口）
├── README.md                                   ← 使用说明
├── references/                                 ← 共享知识库
│   ├── language/                                ← 语法规范
│   ├── sdk/                                     ← SDK 索引与声明
│   │   ├── indexes/
│   │   ├── classes/
│   │   ├── packages/
│   │   ├── plugins/
│   │   ├── microservices/
│   │   └── manifests/
│   ├── gotchas/                                 ← 公共注意事项与经验
│   │   ├── bigdecimal.md
│   │   ├── bigint.md
│   │   ├── date.md
│   │   ├── dynamicobject.md
│   │   └── README.md
│   ├── docs/                                    ← 各开发类型专属指南
│   │   ├── 脚本控制器开发指南.md
│   │   ├── 业务扩展点开发指南.md
│   │   └── 插件开发指南.md
│   ├── templates/                               ← 各开发类型模板
│   │   ├── kwc-controller-template.md
│   │   ├── extpoint-template.md
│   │   ├── form-plugin-template.md
│   │   ├── bill-plugin-template.md
│   │   ├── ... (其余插件模板)
│   └── examples/                                ← 示例
│       ├── plugins/
│       └── community/
├── install.ps1                                 ← Windows 安装脚本
├── install.sh                                  ← macOS/Linux 安装脚本
├── sdks.zip                                    ← 外部 SDK 扩展包
└── ../bos-plugin-sample-7.0.jar               ← Java 样例 jar（可选，与 skill 同级）
```

外部可选资源（与 skill 安装目录同级）：

- `../bos-plugin-sample-7.0.jar` — Java 样例 jar，用于反编译查找 Java 源码
- `../bos-docs/` — 外部知识盘，仅在仓库内 `references/` 不足时使用

## 固定入口

### examples

- `references/examples/README.md`
- `references/examples/plugins/README.md`
- `references/examples/plugins/插件示例/`

### gotchas

- `references/gotchas/README.md`
- `references/gotchas/bigdecimal.md`
- `references/gotchas/bigint.md`
- `references/gotchas/date.md`
- `references/gotchas/dynamicobject.md`
- `references/gotchas/serialization.md`

### docs

- `references/docs/README.md`
- `references/docs/脚本控制器开发指南.md`
- `references/docs/业务扩展点开发指南.md`
- `references/docs/插件开发指南.md`

### templates

- `references/templates/README.md`
- `references/templates/kwc-controller-template.md`
- `references/templates/extpoint-template.md`

### sdk

- `references/sdk/README.md`
- `references/sdk/strategy.md`
- `references/sdk/indexes/class-index.md`
- `references/sdk/indexes/method-index.md`
- `references/sdk/indexes/methods-by-name.md`
- `references/sdk/indexes/scenario-index.md`
- `references/sdk/indexes/keyword-index.md`

### language

- `references/language/README.md`

## 优先阅读

1. **任务起始必须完整加载 `references/gotchas/README.md`**，作为整次会话的运行时约束真相源（详见下一节「约束加载策略」）
2. 先确认 `references/` 目录结构完整
3. 再找 `references/examples/` 中最接近的示例
4. 如果用户提到 `KWC`、`脚本控制器`、`controller`、`REST API`、`Web API`，先读 `references/docs/脚本控制器开发指南.md` 和 `references/templates/kwc-controller-template.md`
5. 如果用户提到 `扩展点`、`extension`、`extpoint`、`业务扩展`，先读 `references/docs/业务扩展点开发指南.md` 和 `references/templates/extpoint-template.md`
6. 如果用户提到 `插件`、`plugin`、`表单插件`、`单据插件`、`列表插件`、`操作插件`，先读 `references/docs/插件开发指南.md`
7. 若任务命中金额/日期/DynamicObject/BigInt/序列化等具体场景，**一次性**补读 `references/gotchas/` 下对应专题文档（`bigdecimal.md` / `date.md` / `dynamicobject.md` / `bigint.md` / `serialization.md`）
8. 如果需要插件骨架或占位代码，读 `references/templates/README.md`
9. 如果涉及 SDK，先读 `references/sdk/README.md`、`strategy.md` 和 `indexes/`
10. 如果涉及语法、关键字或语言限制，读 `references/language/README.md`

## 约束加载策略

所有运行时约束统一收敛到 `references/gotchas/`，上层 `docs/` 指南与 `templates/` 模板通过引用使用。为避免重复文件 I/O 和上下文污染，必须遵守以下加载规则：

- **会话级一次性加载**：`references/gotchas/README.md` 在任务起始时**一次性完整读入**，加载后常驻当次会话上下文，后续整个任务过程中**不得再次 read_file 同一文件**
- **专题文档同规则**：`bigdecimal.md` / `bigint.md` / `date.md` / `dynamicobject.md` / `serialization.md` 在本次任务首次命中对应场景时一次性完整加载，加载后同样常驻上下文，不重复读取
- **引用仅作定位锚点**：`docs/` 指南与 `templates/` 模板中出现的「详见坑 X」「详见 `gotchas/README.md` 坑 Y」「详见 `xxx.md`」等表述，仅用于**在已加载的上下文内快速定位**约束条目，**不触发新的文件读取**
- **禁止约束重复罗列**：`docs/` 与 `templates/` 中不得复制 gotchas 中的约束细节（症状/原因/错写法/正写法），只保留「一句话引用 + 专属要点」；发现重复应收敛回 gotchas
- **单向引用不可逆**：引用方向固定为 `docs/` → `gotchas/`、`templates/` → `gotchas/`、`docs/` → `templates/`；反向引用（gotchas → docs/templates）严格禁止

## 降级查找顺序

当 skill 里只给了目录、没有给具体文件时，必须按下面顺序继续收敛，直到落到具体文件，而不是停在目录名上：

1. 先开该目录下的 `README.md`
2. 再看该目录下的文件名是否已经能直接定位目标
3. 如果只知道类名、方法名、事件名、插件类型，优先回到 `sdk/indexes/`
4. 如果只知道"场景"，优先回到 `examples/plugins/README.md` 和对应"场景拆分"目录的 `README.md`
5. 如果仍然不够，再在目标目录里做关键字检索
6. 索引和 examples 都不够时，再降级到 `sdk/manifests/`
7. 仍不足时，再看本地 `.d.ts`、`jar` 反编译结果或在线 Javadoc

## 目录级路径的收敛规则

### 从 examples 收敛

- 已知是插件案例时，先开 `references/examples/plugins/README.md`
- 再根据插件类别进入 `插件示例/表单插件-场景拆分/README.md`、`插件示例/字段控件-场景拆分/README.md`、`插件示例/控件-场景拆分/README.md`、`插件示例/单据体-场景拆分/README.md`、`插件示例/报表查询插件-场景拆分/README.md` 这类目录 README
- 只有目录名时，必须继续打开该目录里的具体 `*.md`，不能只回答"去这个目录找"

### 从 docs 收敛

- 已知是 KWC、脚本控制器、Web API、REST API 开发时，先开 `references/docs/README.md`
- 再进入 `references/docs/脚本控制器开发指南.md`
- 如果只需要某一块规则，可继续在该文档中检索 `permission`、`url`、`request`、`response`、`version` 等关键字

### 从 sdk 收敛

- 已知类名：`references/sdk/indexes/class-index.md`
- 已知方法名：`references/sdk/indexes/method-index.md`，如果没有，再看 `methods-by-name.md`
- 已知生命周期或插件类型：`references/sdk/indexes/plugin-index.md`、`methods-lifecycle.md`
- 已知业务词或场景词：`references/sdk/indexes/scenario-index.md`、`keyword-index.md`
- 找到线索后，继续打开 `references/sdk/classes/`、`packages/`、`plugins/`、`microservices/` 下的具体文件

### 从 language 收敛

- 语法总入口先看 `references/language/README.md`
- 再按主题进入 `类.md`、`方法.md`、`变量.md`、`接口.md`、`异常处理.md`、`语法示例.md`

## 本地检索方式

如果目录 README 仍然不够，必须继续做本地检索。优先级如下：

1. 优先 `rg --files` 或 `rg -n`
2. 如果 `rg` 不可用或权限异常，改用 PowerShell：

```powershell
Get-ChildItem -Path 'references/' -Recurse -Include *.md |
  Select-String -Pattern 'SearchEnterEvent|EntryGridBindDataEvent|AbstractReportFormPlugin' -Encoding UTF8
```

3. 如果要先看目录里有什么文件，用：

```powershell
Get-ChildItem -Path 'references/examples/plugins/插件示例/控件-场景拆分'
```

4. 如果要从 `jar` 里找 Java 来源，用：

```powershell
jar tf '<java_sample_jar>' | Select-String 'SearchSample|TreeViewSample|ReportColumnMergePlugin'
```

## 任务路由

### 生成或修改代码

- 如果目标是 KWC 脚本控制器，先读 `references/docs/脚本控制器开发指南.md` 与 `references/templates/kwc-controller-template.md`
- 如果目标是业务扩展点，先读 `references/docs/业务扩展点开发指南.md` 与 `references/templates/extpoint-template.md`
- 如果目标是插件开发，先读 `references/docs/插件开发指南.md`，再根据插件类型选 `references/templates/` 下对应模板
- 如果涉及金额/数值字段，补读 `references/gotchas/bigdecimal.md`
- 如果涉及日期过滤或 QFilter 日期入参，补读 `references/gotchas/date.md`
- 如果涉及 `QueryServiceHelper.query` 或 `DynamicObject` 字段读取，补读 `references/gotchas/dynamicobject.md`
- 如果涉及大整数/Long 类型 ID，补读 `references/gotchas/bigint.md`
- 先读 `references/templates/`
- 再读 `references/examples/` 中最相关的示例
- 生成代码时优先复用已有插件模板和事件写法
- 生成代码前，先确认每个外部类、助手类、事件类、枚举和工具类的真实 import 路径；不能只看到示例里用过就省略 import
- 最终输出代码前，必须逐个自检非全局符号是否已显式 import；不能依赖 IDE、编辑器或运行环境自动补 import
- 如果某个符号不需要 import，必须能明确说明它是运行时全局、当前文件局部定义，或由框架自动注入
- 页面提示、通知、消息框相关方法，必须回到 `IFormView` 或本地声明层确认，不把示例里出现过的方法名直接当成可用 API
- 调用 `obj.method()` 前，必须确认 `method` 属于 `obj` 当前类型或其声明继承链；不能只因为别的事件参数或上下文对象上有同名方法就直接套用
- 不允许按"近似名字"猜方法；例如声明里是 `addItemClickListeners(...)`，就不能擅自写成 `addItemClickService(...)`
- 生成代码时不得把事件参数写成 `any`；如果当前版本声明只给出 `BizDataEventArgs` 或 `$.java.util.EventObject`，也必须按声明原样写

### 解释 SDK 或 Java 映射

- 先读 `references/sdk/README.md`
- 再读 `references/sdk/strategy.md`
- 已知类名时优先读 `references/sdk/indexes\class-index.md`
- 已知方法名时优先读 `references/sdk/indexes\method-index.md`；未命中时补读 `methods-by-name.md`
- 只知道场景时优先读 `references/sdk/indexes\scenario-index.md`
- 只知道关键词时优先读 `references/sdk/indexes\keyword-index.md`
- 找到入口后，再读 `references/sdk/classes\`、`packages\`、`plugins\`、`microservices\` 下的具体文件
- 索引不足时，再降级到 `references/sdk/manifests\`
- 如果维护者本地额外挂载了外部知识盘，再按 `strategy.md` 进入外部扩展层
- 如果 `local-paths.json` 中配置了 `bos_docs_path`，把它视为外部知识盘主入口；只有仓库内资料不足时才进入
- 命中外部 `*-description.md` 时，先读描述卡；只有需要真实写法、坑点或运行时边界时，再继续读配套 `*-example.md`
- 仍不足时，再读取本地最相关的 `.d.ts` 或在线 Javadoc

### 诊断问题或做风险审查

- 按开发类型先读对应指南：KWC → `references/docs/脚本控制器开发指南.md`；扩展点 → `references/docs/业务扩展点开发指南.md`；插件 → `references/docs/插件开发指南.md`
- 运行时报错或类型异常 → `references/gotchas/README.md` 按症状查坑
- 找同类场景的 `references/examples/`
- 核对 `references/sdk/` 中的类、方法和生命周期说明
- 最后核对 `references/language/README.md` 及相关语法条目

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
- 不得定义 `static` 方法或 `static` 变量（含类静态字段、`static readonly`）
- 如果信息缺失，提供有边界的假设方案，而不是虚假的确定答案
- 当用户指出示例、模板或生成代码存在错误时，不能只修当前片段；必须继续判断这个问题是否应沉淀成可复用约束，并按影响范围回写到 `SKILL.md`、`references/sdk/strategy.md`、对应知识卡、索引、模板或示例入口，避免同类问题重复生成
