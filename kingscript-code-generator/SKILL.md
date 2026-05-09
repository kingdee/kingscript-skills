---
name: kingscript-code-generator
description: "用 KingScript 做 KWC 脚本控制器后端 API 开发（REST/Web API）与数据 CRUD（DynamicObject / QueryServiceHelper / QFilter）。优先复用本仓库内的 SDK 索引、运行时约束、安全模板，不编造 API。"
---

# Kingscript 后端开发入口

本 skill 聚焦「用 KingScript 在 KWC 脚本控制器里写后端 API + 数据 CRUD」。不覆盖表单/列表/操作/报表等老式前端耦合插件体系。

## 何时触发

- 写或改 KWC 脚本控制器、REST / Web API
- 用 KingScript 做新增、修改、查询、删除数据
- 诊断 KWC 运行时报错、审查生成代码
- 解释 SDK 类、方法、Java 开放能力映射

## 任务路由速查

| 用户问什么 | 先读这里 |
|---|---|
| KWC 控制器怎么配、怎么写、怎么部署 | `references/backend/脚本控制器开发指南.md` |
| 起手模板 / 保守写法 | `references/backend/controller-safe-template.md` |
| 数据 CRUD 怎么写 | `references/sdk/classes/QueryServiceHelper.md` + `QFilter.md` + `DynamicObject.md` + `BusinessDataServiceHelper.md` |
| 金额 / BigDecimal / 大整数 ID | `references/backend/runtime-number-bridge.md` |
| 日期字段 / QFilter 日期入参 | `references/backend/runtime-date-bridge.md` |
| DynamicObject 读取规范 | `references/backend/runtime-dynamicobject.md` |
| 运行时报错 / 500 空体 | `references/backend/faq-runtime-pitfalls.md` + `references/sdk/indexes/error-index.md` |
| 不知道用哪个类 | `references/sdk/indexes/keyword-index.md` 或 `scenario-index.md` |
| 已知类名找说明 | `references/sdk/classes/<ClassName>.md`（若无卡片则查 `indexes/module-index.md` 定位模块） |
| 已知方法名找说明 | `references/sdk/indexes/methods-hot.md`（后端高频）|
| 语法 / 关键字 / 命名 | `references/syntax/` |
| Java ↔ KingScript 类型桥接 | `references/backend/runtime-number-bridge.md` + `runtime-date-bridge.md` + `runtime-dynamicobject.md` |

## 资料地图（叶子文件直达）

### 定制开发专题（必读）

- `references/backend/脚本控制器开发指南.md` — KWC 控制器完整开发指南（配置、URL、权限、请求/响应 API）
- `references/backend/controller-safe-template.md` — 保守起手模板（含 `toJavaSafe` 递归转换）
- `references/backend/faq-runtime-pitfalls.md` — P0 硬约束总表 + 14 条常见坑
- `references/backend/runtime-number-bridge.md` — BigDecimal / Long / BigInt 运行时约束
- `references/backend/runtime-date-bridge.md` — Java Date ↔ JS Date 桥接约束
- `references/backend/runtime-dynamicobject.md` — DynamicObject 读取规范

### SDK 索引（按已知信息反查）

- `references/sdk/indexes/methods-hot.md` — 后端 CRUD 高频方法
- `references/sdk/indexes/keyword-index.md` — 按关键字/口语反查
- `references/sdk/indexes/scenario-index.md` — 按业务场景反查
- `references/sdk/indexes/error-index.md` — 按报错反查
- `references/sdk/indexes/deprecated-index.md` — 废弃/不推荐清单
- `references/sdk/indexes/module-index.md` — 按模块反查
- `references/sdk/indexes/microservice-index.md` — 按微服务反查

### SDK 类知识卡（CRUD 核心）

- **数据访问**：`QueryServiceHelper` · `QFilter` · `QCP` · `BusinessDataServiceHelper` · `DBRoute`
- **数据模型**：`DynamicObject` · `DynamicObjectCollection`
- **元数据**：`EntityType` · `MainEntityType` · `EntryType` · `SubEntryType` · `EntityMetadataCache`
- **基础资料元数据**：`BasedataProp` · `MulBasedataProp` · `MasterBasedataProp`
- **弹性域元数据**：`FlexEntityType` · `FlexProp` · `FlexProperty`
- **操作结果与校验**：`OperationResult` · `ValidateResult` · `ValidationErrorInfo` · `ErrorLevel`
- **数值 / 日期**：`BigDecimal` · `Date`
- **请求上下文 / 异常 / 序列化**：`RequestContext` · `KDException` · `SerializationUtils`

所有类文件统一放在 `references/sdk/classes/<ClassName>.md`。

### SDK 其他

- `references/sdk/strategy.md` — SDK 检索策略与降级路线
- `references/sdk/manifests/modules.json` — 21 个业务域模块统计（识别 `@constellation/*` / `@cosmic/*` 归属）
- `references/sdk/manifests/summary.json` — SDK 整体统计

### 语法 / 关键字 / 命名

- `references/syntax/命名规范.md`
- `references/syntax/保留关键字.md`
- `references/syntax/变量.md`
- `references/syntax/方法.md`
- `references/syntax/类.md`
- `references/syntax/接口.md`
- `references/syntax/条件判断.md`
- `references/syntax/循环.md`
- `references/syntax/异常处理.md`
- `references/syntax/模块及引用.md`
- `references/syntax/语法示例.md`

## 运行时硬约束（P0）

完整规则、代码例子、症状/原因/错误写法都在 `references/backend/faq-runtime-pitfalls.md` 顶部的「P0 总表 + 自检清单」。输出代码前必须逐条核对，违反一条即视为不合格。精要回顾：

1. 禁 `?.` / `??` / 深层解构 / 对 Java 对象链式 JS 调用
2. 禁用 `Number()/toFixed()/Number.isFinite()` 处理 Java 数值；大整数走 `BigInt("...")`
3. 禁把 Java Date 当 JS Date 用
4. DynamicObject 统一 `row.get('fieldKey')`；分录字段必须带 `entryentity.` 前缀
5. 顶层响应必须是对象（不允许返回数组）
6. 响应内容必须是 Java 集合（`ArrayList` / `HashMap` / `HashSet`），用 `toJavaSafe` 递归转换
7. adapterApi 必查 `config.app` / `config.isvId`
8. 禁定义 `static` 方法与 `static` 变量

## 降级检索链路

1. 用户只给了类名 → `sdk/classes/<ClassName>.md`（无卡片则按 `sdk/indexes/module-index.md` 反查模块）
2. 只给了方法名 → `sdk/indexes/methods-hot.md`
3. 只给了业务词 → `sdk/indexes/scenario-index.md` 或 `keyword-index.md`
4. 只给了报错 → `sdk/indexes/error-index.md` + `backend/faq-runtime-pitfalls.md`
5. 仍不足 → 本地 `.d.ts` 或在线 Javadoc；未命中必须明确声明假设与缺口，不得编造

## 输出规则

每次输出按下列结构：

1. **场景**：一句话说清楚目标
2. **假设**：列出当前依赖的前置条件（实体、字段、权限、运行时版本）
3. **代码或方案**：按上面 P0 硬约束给出，所有非全局符号必须显式 import
4. **风险**：列明未验证的点、已知的运行时坑位
5. **待确认问题**：需要用户回答后才能收敛的信息

代码硬约束：

- 生成代码前必须确认每个外部类、助手类、工具类的真实 import 路径
- 不得依赖 IDE 自动导入；不需要 import 的符号必须说明理由（全局 / 局部定义 / 框架注入）
- 调 `obj.method()` 前必须确认 `method` 属于 `obj` 当前类型或其声明继承链
- 不允许按「近似名字」猜方法（例：声明是 `addItemClickListeners`，就不能写 `addItemClickService`）
- 事件参数不得写成 `any`，按声明层类型原样写

## 禁止事项

- 不编造 Kingscript API、事件名、上下文对象结构
- 不假设 TypeScript 声明保证运行时可用
- 不忽略权限、租户、组织、账套、生命周期边界
- 不定义 `static` 方法或 `static` 变量（含 `static readonly`）
- 当用户指出生成代码有问题时，不仅修当前片段；还要判断是否应沉淀成可复用约束，并回写到 SKILL.md 或对应运行时文档，避免同类问题再次发生
