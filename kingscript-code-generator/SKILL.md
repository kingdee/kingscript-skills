---
name: kingscript-code-generator
description: "用于处理 Kingscript 定制化任务，包括脚本生成或修改、SDK 声明解释、Java 开放能力映射、运行时错误诊断、实现风险审查或二开模式设计。优先复用共享的示例、模板、SDK 索引和语法索引，不编造不可用的 API。"
---

# Kingscript 专家

作为 AI Agent 处理 Kingscript 二开任务的入口 skill 使用。

## 目录结构

```
./
├── SKILL.md                                    ← 本文件（通用 skill 定义）
├── CLAUDE.md                                   ← Claude Code 入口
├── AGENTS.md                                   ← Codex 入口
├── README.md                                   ← 使用说明
├── references/                                 ← 共享知识库
│   ├── docs/                                     ← 定制开发文档
│   │   ├── 脚本控制器开发指南.md
│   │   ├── controller-safe-template.md
│   │   ├── runtime-bigdecimal.md
│   │   ├── runtime-bigint.md
│   │   ├── runtime-date-bridge.md
│   │   ├── runtime-dynamicobject.md
│   │   └── faq-runtime-pitfalls.md
│   ├── examples/                               ← 示例
│   │   └── plugins/
│   ├── sdk/                                    ← SDK 索引与声明
│   │   ├── indexes/
│   │   ├── classes/
│   │   ├── packages/
│   │   ├── plugins/
│   │   ├── microservices/
│   │   └── manifests/
│   ├── templates/                              ← 插件模板
│   └── language/                                ← 语法规范
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

### docs

- `references/docs/README.md`
- `references/docs/脚本控制器开发指南.md`
- `references/docs/controller-safe-template.md`
- `references/docs/runtime-bigdecimal.md`
- `references/docs/runtime-bigint.md`
- `references/docs/runtime-date-bridge.md`
- `references/docs/runtime-dynamicobject.md`
- `references/docs/faq-runtime-pitfalls.md`

### templates

- `references/templates/README.md`

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

1. 先确认 `references/` 目录结构完整
2. 再找 `references/examples/` 中最接近的示例
3. 如果用户提到 `KWC`、`脚本控制器`、`controller`、`REST API`、`Web API`，先读 `references/docs/脚本控制器开发指南.md` 和 `references/docs/controller-safe-template.md`；涉及金额/日期/DynamicObject/BigInt 时分别补读对应 `runtime-*.md`
4. 如果需要插件骨架或占位代码，读 `references/templates/README.md`
5. 如果涉及 SDK，先读 `references/sdk/README.md`、`strategy.md` 和 `indexes/`
6. 如果涉及语法、关键字或语言限制，读 `references/language/README.md`

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
- 再进入 `脚本控制器开发指南.md`
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

- 如果目标是 KWC 脚本控制器，先读 `references/docs/脚本控制器开发指南.md` 与 `references/docs/controller-safe-template.md`
- 如果涉及金额/数值字段，补读 `references/docs/runtime-bigdecimal.md`
- 如果涉及日期过滤或 QFilter 日期入参，补读 `references/docs/runtime-date-bridge.md`
- 如果涉及 `QueryServiceHelper.query` 或 `DynamicObject` 字段读取，补读 `references/docs/runtime-dynamicobject.md`
- 如果涉及大整数/Long 类型 ID，补读 `references/docs/runtime-bigint.md`
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

- 如果问题发生在 KWC controller、接口路由、权限配置、请求响应处理上，先读 `references/docs/脚本控制器开发指南.md`
- 先找同类场景的 `references/examples/`
- 再核对 `references/sdk/` 中的类、方法和生命周期说明
- 最后核对 `references/language/README.md` 及相关语法条目

## 运行时兼容性硬约束（P0，KWC/Controller）

脚本控制器代码默认遵循"运行时稳定优先"，而不是"语法现代优先"。

除非项目内已有可运行示例明确验证，否则默认强制以下约束：

1. 禁止默认使用高风险现代语法
   - 禁用 optional chaining：`?.`
   - 禁用 nullish coalescing：`??`
   - 禁用深层对象解构
   - 禁止对 Java 返回对象直接做链式 JS 调用
   - 禁止依赖现代浏览器/Node 运行时特性的全局 API 写法
2. 禁止把 Java 数值对象当原生 JS number 直接处理
   - 禁用 `Number(value)`、`Number.isFinite(value)`、`value.toFixed(...)`
   - 禁用 `value + 1` 这类隐式数值运算
   - 仅做轻量聚合/展示时，使用保守转换：先 `${value}`，再 `parseFloat(...)`，再 `isNaN(...)` 兜底
3. 日期字段禁止默认按 JS Date 完整等价处理
   - 不默认假设 Java Date 与 JS `Date` 完全等价
   - 避免复杂日期运算（时区、`setHours`、叠加偏移）
   - Date 比较必须用 `compareTo()` 或 `getTime()`，禁止用 `>` `<` 运算符
   - `getDay()` 返回 1~7（非 JS 的 0~6），周日=1
   - 禁止直接使用 `row.getDate(field)`，某些字段类型会抛不可捕获异常
   - 无成熟模板时，优先"宽查询 + 脚本内格式化聚合"
4. DynamicObject 读取强约束
   - 统一使用 `row.get('fieldKey')`
   - 禁止 `row?.get?.(...)`
   - 禁止对 `row.get(...)` 返回值直接做复杂链式处理
   - 先取值，再显式转换（字符串/数值）
   - 字段名必须对照实体元数据确认，不可猜测
   - 分录字段必须带分录标识前缀（如 `entryentity.kdtest_field`）
5. 响应数据强约束
   - 顶层响应必须是对象
   - 不允许顶层直接返回数组
   - `response.ok` 入参中所有 JS 原生数据结构必须转为 Java 集合类型：`[]` → `ArrayList`、`{}` → `HashMap`、`Set` → `HashSet`（建议使用 `toJavaSafe()` 递归转换）
6. 集合遍历约束
   - `DynamicObjectCollection` 禁止使用 `for-of`，只能用 `size()+get(i)` 或 `iterator`
7. BigInt/Long 精度约束
   - Java 返回的 Long/BigInteger ID 必须用 `BigInt()` 包装，禁止赋值给 JS `number`
   - QFilter 查询中的 ID 必须以 `BigInt` 形式传入
8. DB 查询约束
   - `QueryServiceHelper.query` 只有 4 参数签名 `(entity, fields, qfilters, orderBy)`，禁止传入第 5 个参数
9. 异常处理约束
   - 禁止使用 `e.message` / `e.getMessage()` / `String(e)`，统一用 `'' + e`
10. adapterApi 运行时兜底检查
    - 若前端通过 adapterApi 调用，必须检查 `config.app` 与 `config.isvId` 在运行时可用
11. KS static 限制
    - KS 代码中禁止定义 `static` 方法
    - KS 代码中禁止定义 `static` 变量（含类静态字段、`static readonly`）

## 生成策略（KWC/Controller）

当存在多种写法时，按以下优先级选择：

1. 已有项目/示例明确验证可运行的写法
2. 保守 ES 子集写法（以运行时稳定为第一目标）
3. Java 对象桥接风险更低的写法
4. 可读性更高但运行时风险未知的现代语法（默认降级不用）

## 输出前检查清单（KWC/Controller）

- [ ] 是否出现 `?.` 或 `??`？如有，必须移除或明确给出已验证运行时依据
- [ ] 是否对金额/数值字段直接使用 `Number()/toFixed()/Number.isFinite()`？如有，必须改为保守转换
- [ ] 是否对 Java Date 使用了运算符比较或复杂 JS 日期运算？如有，必须改为 `compareTo()`/`getTime()` 或更稳方案
- [ ] 是否按 JS 0~6 范围使用了 `getDay()` 返回值？（KingScript 实际返回 1~7）
- [ ] 是否对 QueryServiceHelper.query / DynamicObject 结果统一使用 `row.get('fieldKey')` 读取？
- [ ] 是否将顶层响应包装为对象，且数组字段已转为 `ArrayList`？
- [ ] 是否对 `DynamicObjectCollection` 使用了 `for-of`？如有，必须改为 `size()+get(i)` 或 `iterator`
- [ ] Long/BigInt ID 是否已用 `BigInt()` 包装，而非直接赋值给 `number`？
- [ ] `QueryServiceHelper.query` 是否只传了 4 个参数？
- [ ] catch 块中是否使用了 `e.message` / `e.getMessage()`？如有，必须改为 `'' + e`
- [ ] 若前端走 adapterApi，是否已确认 `config.app` / `config.isvId` 运行时非空？
- [ ] 是否定义了 `static` 方法或 `static` 变量？如有，必须删除并改为实例级实现

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
