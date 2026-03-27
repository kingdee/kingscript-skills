# Java-Kingscript Bridge

这个文档用于回答一个高频问题:

- Java SDK 里的对象，在 Kingscript 里到底该怎么理解和使用

资料主要来自两部分:

- 本地 Kingscript 声明，例如项目中的 `node_modules/@cosmic/bos-core`
- Java SDK / Javadoc，以及维护者本地挂载的外部 SDK 文档资料

## 核心原则

- Kingscript 能直接调用很多 Java 对象，但它们不是原生 JS 对象。
- 看到返回值是 `long`、`BigDecimal`、`Date`、`List`、`Map`、`DynamicObject` 时，优先按 Java 对象理解。
- 不确定时先看本地 `@cosmic/bos-core` 的声明签名，再看知识卡或示例。

## 常见映射

| Java / SDK 类型 | Kingscript 里的常见表现 | 使用建议 |
|------|------|------|
| `String` | 字符串 | 可按普通字符串用 |
| `boolean` / `int` | 基本值 | 可直接判断或比较 |
| `long` / `Long` | Java 长整型 | 不要假定等于 JS 安全整数 |
| `BigDecimal` | Java 对象 | 用 `compareTo`、`add`、`subtract` 等方法 |
| `Date` | Java 日期对象 | 优先调用 Java 侧方法或平台工具，不要假定是 JS `Date` |
| `List<T>` | Java 集合 | 优先用 `size()`、`get(index)` |
| `Map<K,V>` | Java 映射 | 优先用 `get(key)`、`put(key, value)` |
| `DynamicObject` | 平台数据实体 | 用字段标识取值赋值 |
| `DynamicObjectCollection` | 平台实体集合 | 用 `size()`、`get(index)`、`addNew()` |
| `EventObject` / 事件参数类 | Java 事件对象 | 优先按知识卡里的方法读取 |

## 高风险类型

### 1. `Long`

- 常见来源: 主键、组织 ID、基础资料 ID
- 风险: 直接按 JS number 处理可能有精度问题
- 建议: 尽量保持对象原样透传，或者只在展示时转字符串

### 2. `BigDecimal`

- 常见来源: 金额、数量、税额、汇率
- 风险: 用 `+`、`-`、`*`、`/` 做运算容易出错
- 建议: 使用 `compareTo`、`add`、`subtract`、`multiply`、`divide`

### 3. `List`

- 常见来源: 查询结果、错误集合、成功主键集合
- 风险: 当成 JS `Array` 直接 `map/filter`
- 建议: 先确认是否已经转成数组；没有的话优先 `size()` + `get(index)`

### 4. `DynamicObject`

- 常见来源: 单据头、分录、基础资料、查询结果
- 风险: 误以为字段就是普通对象属性
- 建议: 优先通过平台方法按字段标识读写，参考 [../classes/DynamicObject.md](../classes/DynamicObject.md)

## 常见问法对应入口

- “为什么这个 ID 比较不准” -> `Long`
- “金额比较为什么不对” -> `BigDecimal`
- “为什么不能直接当数组遍历” -> `List`
- “分录怎么拿、怎么加一行” -> [../classes/DynamicObjectCollection.md](../classes/DynamicObjectCollection.md)
- “操作结果里怎么拿失败原因” -> [../classes/OperationResult.md](../classes/OperationResult.md)

## 模板和示例的处理原则

- 模板里尽量使用具体事件参数类型，不再默认 `any`
- 示例代码优先展示 Java 对象的正确调用方式
- 如果某个对象的桥接边界仍不明确，不编造，回退到本地声明和 Javadoc
