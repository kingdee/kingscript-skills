# KingScript 注意事项（Gotchas）

本目录存放 KingScript 开发中常见的注意事项、经验总结和容易踩的坑。适用于所有开发类型（KWC 控制器、插件、扩展点、工具类）。

## 运行时坑位速查

按"症状速查"组织，每个坑位只保留核心信息（症状、原因、正确写法）。详细技术细节、代码示例和自检清单请跳转对应专题文档。

### 通用坑位

#### 坑 1：使用 `?.` / `??`，部署成功但运行时报错

- **症状**：脚本部署成功，但调用接口时报语法不兼容或方法不存在。
- **原因**：目标运行时不支持 optional chaining / nullish coalescing。
- **错误写法**：`const x = obj?.a?.b ?? ''`
- **正确写法**：显式空值判断，采用保守 ES 子集。

#### 坑 2：金额字段是 BigDecimal，直接当 JS number 用

- **症状**：金额计算或格式化抛出运行时异常。
- **原因**：`QueryServiceHelper.query` / `DynamicObject.get` 返回的金额字段运行时常见为 Java `BigDecimal`，不是原生 JS `number`。
- **错误写法**：`Number(value)`、`value.toFixed(2)`、`Number.isFinite(value)`
- **正确写法**：先 `${value}` 字符串化，再 `parseFloat`，再 `isNaN` 兜底。
- **详见**：`bigdecimal.md`

#### 坑 3：KS 代码定义 `static` 成员

- **症状**：运行时行为与预期不一致，不同环境表现不同。
- **原因**：KS 运行时和脚本装载机制下，静态成员兼容边界不稳定。
- **错误写法**：`static loadData() {}`、`static cache = {}`
- **正确写法**：全部改为实例方法和实例变量。

#### 坑 4：Java 异常对象访问 `.message` / `.getMessage()` 不可靠

- **症状**：`catch(e) { String(e.message) }` 二次抛异常，导致 500。
- **原因**：Java 异常对象的 `.message` 属性访问在 KS 运行时不稳定。
- **错误写法**：`e.message`、`e.getMessage()`、`String(e)`
- **正确写法**：统一用 `'' + e`：

```ts
try {
  // ...
} catch (e) {
  response.throwException('操作失败: ' + e, 500, 'ERROR');
}
```

#### 坑 5：`DynamicObjectCollection` 不支持 JS `for-of`

- **症状**：`for (const row of rs)` 抛不可捕获异常，HTTP 500。
- **原因**：Java 集合类型不支持 JS 的 `Symbol.iterator` 协议。
- **错误写法**：`for (const row of rs) { ... }`
- **正确写法**：`size()+get(i)` 或 `iterator`。
- **详见**：`dynamicobject.md`

#### 坑 6：查询不存在的字段 → HTTP 500 空体

- **症状**：查询了实体中不存在的字段名，直接 HTTP 500，catch 接不住。
- **原因**：字段名必须与实体元数据严格匹配。
- **正确写法**：开发前对照实体元数据确认字段清单，不可猜测。
- **详见**：`dynamicobject.md`

### KWC 控制器专属坑位

#### 坑 7：顶层直接返回数组，前端解析异常

- **症状**：前端适配层报解析错误。
- **原因**：接口顶层响应契约不稳定。
- **错误写法**：`response.ok(items)`
- **正确写法**：`response.ok({ items: items })`（转为对象包装）

#### 坑 8：`response.ok` 入参含 JS 原生数据结构，序列化后变成 `{}`

- **症状**：`response.ok({ list: [{a:1}] })` 返回的 JSON 里 `list` 变成 `{}`。
- **原因**：Java 序列化层只识别 Java 集合类型，不识别 JS 原生 `[]` / `{}`。
- **错误写法**：`response.ok({ items: [{id:1}] })`
- **正确写法**：`[]` → `new ArrayList()`、`{}` → `new HashMap()`。建议使用 `toJavaSafe(obj)` 递归转换。
- **详见**：`serialization.md`

#### 坑 9：HashMap 嵌套 JS 原生数据结构同样失效

- **症状**：外层用了 `new HashMap()`，但内层数组仍是 JS 原生 `[]`，序列化后依然变成 `{}`。
- **原因**：Java 序列化是递归的，内层也必须是 Java 集合类型。
- **错误写法**：`map.put('items', [{id:1}])`
- **正确写法**：递归确保所有层级都转为 Java 集合类型。建议使用 `toJavaSafe(obj)`。
- **详见**：`serialization.md`

#### 坑 10：前端 `config.app` 为空，adapterApi 报错

- **症状**：请求发起失败，报 `Invalid config app provided`。
- **原因**：运行时配置为空或未做兜底检查。
- **正确写法**：发起请求前确认 `config.app` / `config.isvId` 可用。

#### 坑 11：JS Date 参与 QFilter 后查询异常

- **症状**：查询范围偏移、丢数或结果为空。
- **原因**：错误假设 Java Date 与 JS Date 完全等价。
- **错误写法**：复杂日期偏移后直接作为 `QFilter` 入参。
- **正确写法**：宽查询 + 脚本内聚合。
- **详见**：`date.md`

#### 坑 12：分录字段查询缺少 `entryentity.` 前缀

- **症状**：`QueryServiceHelper.query` 返回 HTTP 500 空响应体。
- **原因**：分录字段必须带分录标识前缀（默认 `entryentity`，多分录可能为 `entryentity1` 等）。
- **错误写法**：`'kdtest_combofield'`（分录字段不带前缀）
- **正确写法**：`'entryentity.kdtest_combofield'`
- **详见**：`dynamicobject.md`

#### 坑 13：`QueryServiceHelper.query` 当作 5 参数调用

- **症状**：返回 HTTP 500 空响应体。
- **原因**：该方法只有 4 参数签名 `(entity, fields, qfilters, orderBy)`，无 limit 位。
- **错误写法**：`QueryServiceHelper.query('entity', 'f1,f2', [], '', 0)`
- **正确写法**：`QueryServiceHelper.query('entity', 'f1,f2', [], '')`

#### 坑 14：`row.getDate(field)` 抛不可捕获异常

- **症状**：`try { row.getDate('bizdate') } catch(e) {}` 接不住，直接 500。
- **原因**：`getDate()` 异常发生在 KS 运行时深层，脚本层 catch 无法捕获。
- **错误写法**：`const date = row.getDate('bizdate')`
- **正确写法**：`row.get(field)` 取值后转字符串解析。
- **详见**：`dynamicobject.md`

#### 坑 15：QFilter 容器使用 ArrayList 导致查询异常

- **症状**：传入 `QueryServiceHelper.query` 或 `BusinessDataServiceHelper.load` 的 qfilters 参数后，运行时报类型不匹配或查询无结果。
- **原因**：qfilters 参数（第三参数）必须是 JS 原生数组 `[]`，不能用 `new ArrayList()` 存放 QFilter 对象。
- **错误写法**：

```ts
const filters = new ArrayList();
filters.add(new QFilter("status", "=", "A"));
QueryServiceHelper.query("entity", "id", filters, "");
```

- **正确写法**：

```ts
const filters = [new QFilter("status", "=", "A")];
QueryServiceHelper.query("entity", "id", filters, "");
```

#### 坑 16：QFilter "in" 操作符的值使用 JS 数组导致匹配失败

- **症状**：`in` 条件构造后查询结果为空或行为异常。
- **原因**：QFilter 构造器内部按 Java Collection 匹配 "in" 值，JS 原生数组不被识别。
- **错误写法**：`new QFilter("field", "in", ["A", "B", "C"])`
- **正确写法**：

```ts
import { ArrayList } from "@cosmic/bos-script/java/util";

const values = new ArrayList();
values.add("A");
values.add("B");
values.add("C");
const filter = new QFilter("field", "in", values);
```

#### 坑 17：`SaveServiceHelper.save` 传入 entity 字符串导致调用失败

- **症状**：调用 `SaveServiceHelper.save("entityNumber", dyos)` 后保存失败或抛异常。
- **原因**：`save()` 不接受 entity 名称字符串作为第一参数；1 参数重载接收 `DynamicObject[]`，2 参数重载第二参数为 `boolean`（是否提交快照）。
- **错误写法**：`SaveServiceHelper.save("bd_material", [obj])`
- **正确写法**：

```ts
import { SaveServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper/operation";

// 通用场景（1 参数）
SaveServiceHelper.save([obj]);

// 需要提交快照（2 参数）
SaveServiceHelper.save([obj], true);
```

- **import 易错点**：正确路径为 `@cosmic/bos-core/kd/bos/servicehelper/operation`；误引 `@cosmic/bos-core/kd/bos/servicehelper` 会加载 `CtSaveServiceHelper`。

#### 坑 18：`QueryServiceHelper.query` 结果不可直接保存

- **症状**：对 query 返回的 DynamicObject 调用 `SaveServiceHelper.save` 后数据未持久化或抛异常。
- **原因**：`QueryServiceHelper.query` 返回的是只读轻量级查询视图，不含完整元数据（非完整数据包）；只有通过 `BusinessDataServiceHelper` 加载的实体才具备保存能力。
- **错误写法**：

```ts
const rs = QueryServiceHelper.query("bd_material", "id,name", filters, "");
// 试图修改并保存 query 结果 — 失败
```

- **正确写法**：

```ts
// 1. 先 query 获取目标 ID
const rs = QueryServiceHelper.query("bd_material", "id", filters, "");
const id = rs.next() ? BigInt(rs.get("id")) : null;

// 2. 用 BusinessDataServiceHelper 加载完整对象
if (id !== null) {
  const fullObj = BusinessDataServiceHelper.loadSingle(id, "bd_material");
  fullObj.set("name", "新名称");
  SaveServiceHelper.save([fullObj]);
}
```

### 开发环境 / IDE 坑位

#### 坑 19：VSCode 无法识别 `this.getModel()` / `this.getView()` 等插件成员，编辑器飘红

- **症状**：在单据插件 / 表单插件脚本中，`this.getModel()`、`this.getView()`、`this.getPageCache()` 等基类成员在 VSCode 中报红，提示属性不存在；但脚本部署到平台后可正常运行。
- **原因**：VSCode 升级了内置的 TypeScript 版本（≥ 5.10），与脚本 SDK 的 `.d.ts` 解析机制存在兼容性问题，导致继承链上的方法无法被正确识别。问题不在脚本 SDK，而在 IDE 内置 TS 版本。
- **错误处理**：直接忽略飘红、或者改写为非 `this.` 调用以"绕过"提示——会丢失类型补全和静态检查。
- **正确处理**：将项目 TypeScript 锁定到 `5.9.3`，并在 VSCode 中切换到工作区版本。

  1. 在脚本工程根目录安装指定版本：

     ```powershell
     npm install typescript@5.9.3 --save-dev
     ```

  2. 在 VSCode 中打开任意一个 `.ts` 脚本文件，按 `Ctrl+Shift+P` 调出命令面板，输入并执行 `TypeScript: Select TypeScript Version`，选择 `Use Workspace Version`（即 `node_modules/typescript@5.9.3`）。

- **注意**：`Select TypeScript Version` 是按工作区生效的，需在每个脚本项目首次打开时切换一次；切换后 `this.getModel()` / `this.getView()` 等成员应恢复正常补全。

## 专题文档</text>

- `bigdecimal.md` — BigDecimal/金额字段运行时处理约束；`Number()/toFixed()/Number.isFinite()` 禁用与安全替代写法
- `bigint.md` — BigInt/Long 类型 ID 运行时处理约束；大整数精度丢失风险与 `BigInt()` 包装规范；QFilter 查询、DynamicObject 读取、BigInt 运算规则
- `date.md` — Java Date 与 JS Date 桥接风险说明；日期运算、运算符比较、`getDay()` 差异与 QFilter 日期入参的保守处理方式
- `dynamicobject.md` — `DynamicObject` 读取规范；`row.get('fieldKey')` 标准读取姿势、日期字段禁止 `getDate()`、字段名校验原则
- `serialization.md` — JS 原生序列化与 Java 平台序列化的边界说明；两套序列化体系（`JSON.stringify` vs `SerializationUtils`）的混用风险，以及 `response.ok` 的序列化要求

## 使用建议

- 排查线上异常或不确定属于哪一类时，先查上方"运行时坑位速查"
- 涉及 QFilter 查询条件构造，特别注意坑 15（容器用 JS 数组）和坑 16（in 值用 ArrayList）
- 涉及 `SaveServiceHelper.save` 或数据保存操作，注意坑 17（参数签名）和坑 18（query 结果不可保存）
- 编辑器中 `this.getModel()` / `this.getView()` 等成员飘红、与运行时不一致时，参见坑 19（VSCode TypeScript 版本兼容）
- 涉及金额/数值字段，优先阅读 `bigdecimal.md`
- 涉及日期过滤或 QFilter 日期入参，优先阅读 `date.md`
- 涉及 `QueryServiceHelper.query` 或 `DynamicObject` 字段读取，优先阅读 `dynamicobject.md`
- 涉及序列化异常（`response.ok` 返回 `{}`、`SerializationUtils` 报错），优先阅读 `serialization.md`
- 涉及大整数/Long 类型 ID，优先阅读 `bigint.md`
- 如果还需要具体类、方法或声明，再回到 `references/sdk/`
