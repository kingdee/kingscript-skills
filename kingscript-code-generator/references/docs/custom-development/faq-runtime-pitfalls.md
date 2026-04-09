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
