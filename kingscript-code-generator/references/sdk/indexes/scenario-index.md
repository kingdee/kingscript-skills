# SDK 场景索引

按后端开发任务场景组织的 SDK 入口。本索引只覆盖 KWC 脚本控制器 + 数据 CRUD 场景，不含表单/列表/操作/报表等前端耦合插件。

| 场景 | 推荐先看 | 说明 |
|------|----------|------|
| 查询与过滤 | `BusinessDataServiceHelper`、`QueryServiceHelper`、`QFilter`、`QCP` | 从查询数据和构造过滤条件开始 |
| 数据读写 | `DynamicObject`、`DynamicObjectCollection` | 确认拿到的是实体对象还是实体集合，再决定按字段读写还是按行遍历 |
| 分录实体与元数据 | `EntryType`、`SubEntryType`、`EntityType`、`MainEntityType`、`EntityMetadataCache` | 区分分录结构问题、单据头结构问题、字段元数据查询 |
| 基础资料字段 | `BasedataProp`、`MulBasedataProp`、`MasterBasedataProp` | 区分单选、多选、主数据字段底层结构 |
| 弹性域取值 | `FlexProp`、`FlexProperty`、`FlexEntityType` | 值对象、字段属性、维度结构三个层面 |
| 数据库路由 | `DBRoute` | 跨库查询、自定义数据源路由 |
| 上下文与用户信息 | `RequestContext` | 用户、组织、租户、账套 |
| 校验器与操作结果 | `ValidateResult`、`ValidationErrorInfo`、`OperationResult`、`ErrorLevel` | 区分单条错误、整体校验结果、最终操作结果 |
| 类型与运行时桥接 | `BigDecimal`、`Date`、`SerializationUtils` | Java 对象与 JS 原生对象差异；大整数见 `runtime-number-bridge.md` |
| 异常处理 | `KDException` | 后端异常捕获与抛出 |
