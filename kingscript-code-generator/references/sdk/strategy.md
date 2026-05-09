# SDK 检索策略

定义本 skill 的 SDK 检索降级链路，聚焦 KWC 脚本控制器后端 API + 数据 CRUD。

## 目标

- 高频类优先命中知识卡。
- 长尾类通过本地 `.d.ts` 和在线 Javadoc 兜底。
- 明确"何时继续降级，何时停止并声明假设"。

## 降级链路

### 第 1 层：知识卡

- `references/sdk/classes/<ClassName>.md` — 27 个核心类（数据访问、元数据、基础资料/弹性域、运行时上下文等）
- Java ↔ KingScript 类型桥接细节走 `../backend/runtime-number-bridge.md` / `runtime-date-bridge.md` / `runtime-dynamicobject.md`

适用：已知类名且已有知识卡 / 高频类 / 需要用途 + 场景 + 风险 + FAQ。

### 第 2 层：索引

未命中知识卡时按问题类型进入：

- 方法名 → `indexes/methods-hot.md`
- 模块 → `indexes/module-index.md`
- 业务场景 → `indexes/scenario-index.md`
- 关键词 / 口语 → `indexes/keyword-index.md`
- 报错 → `indexes/error-index.md`（配合 `../backend/faq-runtime-pitfalls.md`）
- 废弃 → `indexes/deprecated-index.md`
- 微服务 → `indexes/microservice-index.md`

适用：需要先定位类/包/模块；用户说法与 SDK 正式名称不一致；还没有对应知识卡。

### 第 3 层：模块统计

索引仍不足以回答细节时，读取结构化清单：

- `manifests/summary.json` — 整体统计
- `manifests/modules.json` — 21 个业务域模块统计（识别 `@constellation/*` / `@cosmic/*` 归属）

适用：识别陌生类型属于哪个业务域 / 模块是否在 SDK 范围内。

### 第 4 层：本地声明（.d.ts）

清单无法解释语义或需要更细签名时，读取本地 `@cosmic/bos-core`、`@cosmic/bos-script` 的 `.d.ts`。

- 优先打开单个命中的 `.d.ts`，不整目录扫描。
- 只读取与目标类 / 包 / 方法直接相关的文件。

### 第 5 层：在线 Javadoc

本地声明只有结构、没有语义说明时，读取 [Cosmic V8.0.1 Javadoc](https://dev.kingdee.com/sdk/Cosmic%20V8.0.1/index.html?nav=class)。

适用：需要参数 / 返回值语义、版本信息、废弃说明；本地 `.d.ts` 注释不足。

### 第 6 层：有界回答

以上各层仍不能确认时：

- 明确说明查到了什么 / 缺什么 / 哪些是推断
- 提供有界方案，不编造 SDK 内容

## 检索停止条件

满足任意一条即可停止继续降级：

- 已能确认类 / 场景 / 边界 / 风险
- 已能给出足够可信的结构化回答
- 再继续读取只会增加噪音、不会显著提高确定性

## 不允许的行为

- 跳过索引层直接整目录扫 `node_modules`
- 只看 TypeScript 声明就默认运行时一定可用
- 只确认方法名存在，不确认它属于当前变量类型或其继承链
- 根据近似命名编造 API（例：把 `queryOne` 写成 `queryFirst`）
- 把 A 事件参数、B 事件参数的方法互相挪用
- 在生成代码里用 `any` 代替声明层给出的具体类型
- 本地和在线来源冲突时擅自选一个而不说明

## 输出要求

涉及 SDK 解释时至少说明：命中的类或方法 · 来源层级（知识卡 / 索引 / 清单 / 本地声明 / 在线 Javadoc）· 已确认事实 · 运行时边界 · 待确认项。

## 反馈闭环

当用户或运行时日志证明某段代码有问题时，不只修当前片段，还要判断：

1. 这是单点笔误还是一类会重复出现的生成风险？
2. 如能抽象成稳定规则，就同步回写到：
   - 入口约束：`SKILL.md`
   - 检索规则：`sdk/strategy.md`（本文件）
   - 事实说明：对应 `sdk/classes/` / `sdk/indexes/`
   - 运行时规则：`backend/faq-runtime-pitfalls.md` 顶部 P0 总表

优先沉淀的典型问题：近似命名伪 API · 方法不属于当前对象类型 · 事件参数被写成 `any` · BigDecimal / 大整数 / Java Date 桥接错误 · 响应体未用 `toJavaSafe` 转换。
