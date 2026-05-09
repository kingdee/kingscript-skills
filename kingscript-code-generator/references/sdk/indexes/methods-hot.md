# SDK 高频方法检索（后端 CRUD）

聚焦 KWC 脚本控制器后端 API + 数据 CRUD 的高频方法。不覆盖前端插件生命周期。

## 数据查询

| 方法 | 说明 | 代表类 |
|---|---|---|
| `query` | 返回 `DynamicObjectCollection`，支持 select 字段列表 + QFilter 数组 + 排序 + 分页 | `QueryServiceHelper` |
| `queryOne` | 只取一条，按 QFilter 查询，未命中返回 null | `QueryServiceHelper` |
| `queryPrimaryKeys` | 只返回主键集合，配合后续 `loadFromCache` 使用 | `QueryServiceHelper` |
| `exists` | 存在性判断，用于去重、前置校验 | `QueryServiceHelper` · `QFilter.exists/notExists` |
| `loadSingle` | 按 ID 或 QFilter 读取一条完整的 `DynamicObject`（含分录/基础资料） | `BusinessDataServiceHelper` |
| `load` | 按 IDs 批量加载结构化 `DynamicObject[]` | `BusinessDataServiceHelper` |
| `loadFromCache` | 基础资料走缓存，减少数据库压力 | `BusinessDataServiceHelper` |

## 条件构造（QFilter）

| 方法 | 说明 |
|---|---|
| `new QFilter(field, QCP, value)` | 基本条件；比较符来自 `QCP.equals`/`QCP.large_than` 等 |
| `and` / `or` | 拼接多条件 |
| `exists` / `notExists` | 子查询存在性 |
| `join` | 关联过滤，跨实体取字段 |

## 数据写入与操作

| 方法 | 说明 | 代表类 |
|---|---|---|
| `save` | 保存单个 `DynamicObject` 或集合 | `BusinessDataServiceHelper` · `SaveServiceHelper` |
| `update` | 按主键更新 | `BusinessDataServiceHelper` |
| `delete` | 按主键或 QFilter 删除 | `BusinessDataServiceHelper` · `DeleteServiceHelper` |
| `executeOperate` | 调用标准操作（审核/反审核/提交等），返回 `OperationResult` | `OperationServiceHelper` |

## 元数据读取

| 方法 | 说明 | 代表类 |
|---|---|---|
| `getDataEntityType` | 按实体编码拿到 `MainEntityType` | `EntityMetadataCache` |
| `getSubDataEntityType` | 列表/分录场景只读部分字段的轻量入口 | `EntityMetadataCache` |
| `getProperty` | 从 EntityType 取单个字段属性（`BasedataProp` / `MulBasedataProp` / `FlexProp` 等） | `EntityType` |
| `getPkValue` / `getPkFieldName` | 取主键值 / 主键字段名 | `DynamicObject` · `EntityType` |

## 请求上下文与序列化

| 方法 | 说明 | 代表类 |
|---|---|---|
| `get()` | 取当前租户/账套/用户/语言上下文 | `RequestContext` |
| `toJsonString` / `fromJsonString` | JSON 序列化 / 反序列化（注意大整数） | `SerializationUtils` |

## 使用建议

- 同名方法多类分布时，优先选上表中的"代表类"。
- 方法签名细节回 `../classes/<ClassName>.md`；没有知识卡时按本地 `.d.ts` 核对。
- 涉及 BigDecimal / 大整数 / Java Date 的方法参数，先读 `../../backend/runtime-number-bridge.md` 和 `runtime-date-bridge.md`。
