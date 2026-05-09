# SDK 报错索引

从「报错现象」反查最可能相关的 SDK 类、运行时专题和第一排查入口。

## 使用方式

- 用户贴出具体报错文本时，先按关键词匹配本索引。
- 用户只描述"找不到包"/"类型不对"/"500 空响应"时，也先从这里缩小范围。
- 本索引聚焦 KWC 脚本控制器后端 API + 数据 CRUD 场景。

## 高频报错

### 1. 依赖包无法识别 / 找不到模块

- 现象：`Cannot find module '@cosmic/bos-core/...'`、`找不到包 kd/bos/...`
- 排查：import 路径是否和 SDK 类卡片一致；是否误导入了已废弃/前端独有的包
- 先看：[module-index.md](module-index.md) · [keyword-index.md](keyword-index.md)

### 2. 控制器 500 / 响应空体 / 前端拿不到数据

- 现象：调用 KWC 控制器返回 500；响应体为空；前端 JSON.parse 失败
- 常见根因：
  - 顶层返回了数组而不是对象
  - 响应对象里含 JS 原生 `Array` / `Object` / `Map` / `Set` 等非 Java 集合
  - 响应对象里含 `BigDecimal` / Java Date / DynamicObject 等未转换的原生 Java 句柄
- 先看：[../../backend/faq-runtime-pitfalls.md](../../backend/faq-runtime-pitfalls.md) · [../../backend/controller-safe-template.md](../../backend/controller-safe-template.md)

### 3. QFilter 类型转换错误 / 过滤条件不生效

- 现象：`ClassCastException`、`类型转换错误`、查询结果明显不符预期
- 排查：比较值类型是否与字段真实类型一致；基础资料/组织/枚举是否误传字符串；日期入参是否是 `java.util.Date`；大整数是否用了 `BigInt`
- 先看：[../classes/QFilter.md](../classes/QFilter.md) · [../classes/QCP.md](../classes/QCP.md) · [../../backend/runtime-date-bridge.md](../../backend/runtime-date-bridge.md) · [../../backend/runtime-number-bridge.md](../../backend/runtime-number-bridge.md)

### 4. 长整型精度丢失 / 单号或 ID 变形

- 现象：大整数尾数被改写；单据 ID、基础资料 ID 变成科学计数法；主键比对失败
- 排查：是否把长整型当普通 `number`；是否在 JSON 序列化前做了字符串保护；是否用 `Number()` 强转 Java Long
- 先看：[../../backend/runtime-number-bridge.md](../../backend/runtime-number-bridge.md) · [../classes/BigDecimal.md](../classes/BigDecimal.md) · [../classes/SerializationUtils.md](../classes/SerializationUtils.md)

### 5. 金额计算失真 / BigDecimal 比较异常

- 现象：金额相加减结果尾数异常；`toFixed()`/`Number()` 对金额报错或丢精度；比较两个 BigDecimal 永远不等
- 排查：禁 `Number(v)`/`v.toFixed()`；BigDecimal 必须走 `toSafeNumber` 或保持 Java 侧运算；比较必须用 `compareTo`
- 先看：[../../backend/runtime-number-bridge.md](../../backend/runtime-number-bridge.md) · [../classes/BigDecimal.md](../classes/BigDecimal.md)

### 6. 日期字段读写异常 / QFilter 日期入参报错

- 现象：日期字段读取出 NaN；`new Date(javaDate)` 抛错；QFilter 传日期后查不出数据
- 排查：Java Date 不能直接当 JS Date 用；日期入参必须是 `java.util.Date` 实例
- 先看：[../../backend/runtime-date-bridge.md](../../backend/runtime-date-bridge.md) · [../classes/Date.md](../classes/Date.md)

### 7. 序列化 / 反序列化失败

- 现象：`NotSerializableException`、`反序列化失败`、缓存或消息恢复失败
- 排查：对象是否含 RequestContext、视图上下文、DynamicObject 等不可序列化句柄；序列化边界应改为传主键/DTO
- 先看：[../classes/SerializationUtils.md](../classes/SerializationUtils.md) · [../classes/RequestContext.md](../classes/RequestContext.md)

### 8. DynamicObject 取字段报错 / 值为 null

- 现象：`row.get('xxx')` 抛 `字段不存在`；分录字段取出 null；基础资料 id 读不到
- 排查：字段 key 是否正确（分录字段必须带 `entryentity.` 前缀）；基础资料字段要用 `row.getDynamicObject('field').getPkValue()`；是否漏写 `select` 字段列表
- 先看：[../../backend/runtime-dynamicobject.md](../../backend/runtime-dynamicobject.md) · [../classes/DynamicObject.md](../classes/DynamicObject.md) · [../classes/EntityMetadataCache.md](../classes/EntityMetadataCache.md)

### 9. OperationResult / ValidateResult 校验失败但响应不对齐

- 现象：明明写入成功但 `isSuccess()` 返回 false；`allErrorInfo` 为空；前端收不到错误
- 排查：是否检查了 `getSuccessPkIds` 和 `getValidateResult` 两处；ValidateResult 里 `ValidationErrorInfo` 的 `ErrorLevel` 是否正确传递
- 先看：[../classes/OperationResult.md](../classes/OperationResult.md) · [../classes/ValidateResult.md](../classes/ValidateResult.md) · [../classes/ValidationErrorInfo.md](../classes/ValidationErrorInfo.md)

### 10. KDException / 业务异常不抛到前端

- 现象：抛异常后前端只看到 500；`ErrorCode` 丢失；堆栈被吞
- 排查：是否在 try/catch 里吞掉了 KDException；是否按 ErrorCode 规范抛出；是否在控制器出口做了 toJavaSafe
- 先看：[../classes/KDException.md](../classes/KDException.md) · [../../backend/controller-safe-template.md](../../backend/controller-safe-template.md)

## 使用建议

- 先按报错现象缩小范围，再跳到类卡或运行时专题确认边界。
- 本索引没命中时，继续走 [keyword-index.md](keyword-index.md) · [scenario-index.md](scenario-index.md) · [methods-hot.md](methods-hot.md)。
- 仍不足时再读本地 `.d.ts` 或在线 Javadoc。
