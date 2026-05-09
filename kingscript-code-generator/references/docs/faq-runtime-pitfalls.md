# KWC Controller 运行时常见坑位 FAQ

## 坑 1：Controller 使用 `?.`，部署成功但运行时报错

- 症状：脚本部署成功，但调用接口时报语法不兼容或方法不存在。
- 原因：目标运行时不保证支持 optional chaining/nullish coalescing。
- 错误写法：`const x = obj?.a?.b ?? ''`
- 正确写法：使用显式空值判断，采用保守 ES 子集写法。

## 坑 2：金额字段是 BigDecimal，统计接口返回 500

- 症状：金额计算或格式化步骤抛出运行时异常。
- 原因：将 Java BigDecimal 当成 JS number 直接调用。
- 错误写法：`Number(value)`、`value.toFixed(2)`、`Number.isFinite(value)`
- 正确写法：先字符串化，再 `parseFloat`，最后 `isNaN` 兜底。

## 坑 3：顶层直接返回数组，前端解析异常

- 症状：前端适配层报解析错误，或字段结构不符合约定。
- 原因：接口顶层响应契约不稳定。
- 错误写法：`response.ok(items)`
- 正确写法：`response.ok({ itemsJson: JSON.stringify(items) })`

## 坑 4：前端 `config.app` 为空，adapterApi 报 `Invalid config app provided`

- 症状：请求发起失败，报 `Invalid config app provided`。
- 原因：运行时配置为空或未做兜底检查。
- 错误写法：不检查 `config.app` 和 `config.isvId` 直接发起调用。
- 正确写法：发起请求前确认 `config.app`/`config.isvId` 可用，并提供边界清晰的兜底策略。

## 坑 5：JS Date 参与 QFilter 后查询异常

- 症状：查询范围偏移、丢数或结果为空。
- 原因：错误假设 Java Date 与 JS Date 完全等价。
- 错误写法：复杂日期偏移后直接作为 `QFilter` 入参。
- 正确写法：优先复用已验证模板；无模板时采用“宽查询 + 脚本内聚合”。

## 坑 6：KS 代码定义 static 成员导致兼容风险

- 症状：运行时行为与预期不一致，或在不同环境表现不一致。
- 原因：KS 运行时和脚本装载机制下，静态成员兼容边界不稳定。
- 错误写法：`static loadData() {}`、`static cache = {}`
- 正确写法：全部改为实例方法和实例变量，通过对象实例组织状态。

## 坑 7：response.ok 入参含 JS 原生数据结构，序列化后变成 `{}`

- 症状：`response.ok({ list: [{a:1},{a:2}] })` 返回的 JSON 里 `list` 变成空对象 `{}`，不是数组。
- 原因：KingScript 运行时在 Java 端做序列化时，只识别 Java 集合类型（`ArrayList`、`HashMap`、`HashSet`）；JS 原生 `[]`、`{}` 无法被 Java 序列化层正确识别，数组结构丢失。
- 错误写法：`response.ok({ items: [{id:1}, {id:2}] })`
- 正确写法：所有数组字段必须用 `new ArrayList()` + `.add(item)` 包裹，对象可用 `new HashMap()`。建议使用 `toJavaSafe(obj)` 递归转换函数（见 `controller-safe-template.md`）。

## 坑 8：HashMap 嵌套 JS 原生数据结构同样失效

- 症状：外层用了 `new HashMap()`，但内层数组字段仍是 JS 原生 `[]`，序列化后该字段依然变成 `{}`。
- 原因：Java 序列化是递归的，外层转了 Java 类型不够，内层也必须是 Java 集合类型。
- 错误写法：`map.put('items', [{id:1}, {id:2}])`（外层 HashMap 但内层仍是 JS 数组）
- 正确写法：递归确保所有层级的 JS 原生数据结构都转为对应的 Java 集合类型：`[]` → `ArrayList`、`{}` → `HashMap`、`Set` → `HashSet`。建议使用 `toJavaSafe(obj)` 递归转换函数。

## 坑 9：分录字段查询缺少 `entryentity.` 前缀 → HTTP 500 空体

- 症状：`QueryServiceHelper.query(entity, 'kdtest_combofield,kdtest_amountfield1', [], '')` 返回 HTTP 500 空响应体。
- 原因：分录字段必须带分录标识前缀，不带前缀则服务端找不到字段直接报错。前缀取决于分录标识，最常见的默认分录标识为 `entryentity`，多分录实体可能为 `entryentity1` 等。
- 错误写法：`'kdtest_combofield,kdtest_amountfield1'`
- 正确写法：`'entryentity.kdtest_combofield,entryentity.kdtest_amountfield1'`（单头字段不带前缀）

## 坑 10：`QueryServiceHelper.query` 当作 5 参数调用

- 症状：`query(entity, fields, qfilters, orderBy, 0)` 返回 HTTP 500 空响应体。
- 原因：该方法只有 4 个参数签名 `(entity, fields, qfilters, orderBy)`，没有 limit 参数位。
- 错误写法：`QueryServiceHelper.query('entity', 'f1,f2', [], '', 0)`
- 正确写法：`QueryServiceHelper.query('entity', 'f1,f2', [], '')`（4 参数）

## 坑 11：`row.getDate(field)` 抛不可捕获异常 → HTTP 500 空体

- 症状：`try { row.getDate('kdtest_datefield1') } catch(e) {}` 的 catch 接不住异常，直接 500 空响应体。
- 原因：`getDate()` 在某些字段类型上触发的异常发生在 KS 运行时深层，无法被脚本层 catch 捕获。
- 错误写法：`const date = row.getDate('kdtest_datefield1')`
- 正确写法：先用 `row.getString(field)` 拿到字符串，再做安全解析。正则仅为示例，实际格式取决于字段类型和运行时行为：
```ts
const dateStr = row.get('kdtest_datefield1');
const text = dateStr === null || dateStr === undefined ? '' : `${dateStr}`;
// 如需提取年月，根据实际格式做正则解析
const match = text.match(/(\d{4})-(\d{1,2})/);
const year = match ? match[1] : '';
const month = match ? match[2] : '';
```

## 坑 12：查不存在的字段同样导致 500 空体

- 症状：header 查了 `kdtest_datefield`（实体里只有 `kdtest_datefield1`），直接 HTTP 500 空响应体。
- 原因：查询字段名必须与实体元数据定义严格匹配，拼写错误或不存在的字段名会导致服务端异常，且异常不可被脚本层捕获。
- 错误写法：凭记忆或猜测写字段名
- 正确写法：开发前必须对照实体元数据确认字段清单，明确 header 字段和 entry 字段分类，不可猜测。

## 坑 13：`DynamicObjectCollection` 不支持 JS `for-of` 语法

- 症状：`for (const row of rs)` 抛不可捕获异常，HTTP 500 空响应体。
- 原因：`DynamicObjectCollection` 是 Java 集合类型，不支持 JS 的 `Symbol.iterator` 协议，for-of 触发的异常无法被脚本层 catch。
- 错误写法：`for (const row of rs) { ... }`
- 正确写法：使用 `size() + get(i)` 索引遍历或 `iterator` 遍历：
```ts
// 方式一：索引遍历
for (let i = 0; i < rs.size(); i++) {
  const row = rs.get(i);
}
// 方式二：iterator 遍历
const iterator = rs.iterator();
while (iterator.hasNext()) {
  const row = iterator.next();
}
```

## 坑 14：Java 异常对象访问 `.message` 不可靠

- 症状：`catch(e) { ... String(e.message) ... }` 在某些运行时情况下会二次抛异常，导致 500。
- 原因：Java 异常对象的 `.message` 属性访问在 KS 运行时不稳定，可能触发与原始异常不同的新异常。
- 错误写法：`e.message`、`e.getMessage()`、`String(e)`
- 正确写法：统一用 `'' + e` 通过字符串拼接触发 `toString()`，最稳妥：
```ts
try {
  // ...
} catch (e) {
  response.throwException('操作失败: ' + e, 500, 'ERROR');
}
```
