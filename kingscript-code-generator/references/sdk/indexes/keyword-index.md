# SDK 关键词索引

按常见口语/关键字反查 SDK 类。仅覆盖 KWC 控制器后端 + 数据 CRUD 场景。

| 关键词 | 推荐目标 | 场景 | 说明 |
|--------|----------|------|------|
| 过滤条件 | `QFilter` | 查询与过滤 | 常见于 in、and、or 条件构造 |
| 查询单据 | `BusinessDataServiceHelper` | 查询与过滤 | 按实体加载单据或资料 |
| 查询服务 | `QueryServiceHelper` | 查询与过滤 | 查询单值、单条、多条数据 |
| 查一条 | `QueryServiceHelper` | 查询与过滤 | `queryOne` 场景 |
| 比较符 / 查询操作符 | `QCP` | 查询与过滤 | `QFilter` 的搭配对象（equals、in、not in 等） |
| 动态实体 | `DynamicObject` | 数据读写 | 单据头、分录行、查询结果的高频数据载体 |
| 分录集合 | `DynamicObjectCollection` | 数据读写 | 新增分录、删除分录、遍历分录（注意 for-of 禁用，见 FAQ） |
| 分录类型 | `EntryType` | 元数据 | 单据体实体元数据 |
| 子分录类型 | `SubEntryType` | 元数据 | 子单据体实体元数据 |
| 实体类型 | `EntityType` | 元数据 | 通用实体元数据定义 |
| 主实体类型 | `MainEntityType` | 元数据 | 单据头元数据入口 |
| 元数据缓存 | `EntityMetadataCache` | 元数据 | 按实体读取元数据定义 |
| 基础资料字段 | `BasedataProp` | 元数据 | 基础资料字段元数据 |
| 主数据字段 | `MasterBasedataProp` | 元数据 | 主档基础资料字段元数据 |
| 多选基础资料字段 | `MulBasedataProp` | 元数据 | 多选资料字段结构 |
| 弹性域字段 | `FlexProp` | 元数据 | Flex 字段元数据 |
| 弹性域类型 | `FlexEntityType` | 元数据 | Flex 组合实体结构 |
| 弹性域属性 | `FlexProperty` | 元数据 | Flex 维度属性定义 |
| 数据库路由 | `DBRoute` | 数据访问 | 分库或路由访问 |
| 当前用户 / 当前组织 / 当前租户 / 登录组织 | `RequestContext` | 上下文 | 用户、组织、租户、账套隔离与多账套场景 |
| 序列化 / 反序列化 | `SerializationUtils` | 类型桥接 | Java 对象与字符串互转 |
| 长整型 / 大整数 ID | `runtime-number-bridge.md` | 类型桥接 | 超出 JS number 安全范围，必须用 `BigInt("...")` |
| 金额 / 高精度 | `BigDecimal` + `runtime-number-bridge.md` | 类型桥接 | 金额、税额、汇率等，禁用 `Number()/toFixed()` |
| 日期 / 日期比较 | `Date` + `runtime-date-bridge.md` | 类型桥接 | 运行时 Java Date 对象，禁止等价 JS Date 处理 |
| 操作结果 | `OperationResult` | 操作结果 | 批量结果、成功主键、错误信息 |
| 校验错误 | `ValidationErrorInfo` | 操作结果 | 单条校验失败信息 |
| 校验结果 | `ValidateResult` | 操作结果 | 校验器整体返回结果 |
| 错误级别 | `ErrorLevel` | 操作结果 | 校验失败分级 |
| 平台异常 | `KDException` | 错误处理 | 平台运行时异常 |
| Java 桥接 | `runtime-number-bridge.md` + `runtime-date-bridge.md` + `runtime-dynamicobject.md` | 类型桥接 | Java 对象在 KingScript 中的使用规则 |
