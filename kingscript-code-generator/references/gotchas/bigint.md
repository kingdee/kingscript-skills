# BigInt 运行时处理约定

## 风险说明

Java 端返回的 `Long` / `BigInteger` 类型 ID（如主键 `id`、`PkValue`），在 KingScript 运行时如果不做 `BigInt` 包装，会因 JS `number` 精度上限丢失高位数据。

JS `number` 基于 IEEE 754 双精度浮点，**安全整数范围为 ±2⁵³ - 1（即 ±9007199254740991）**。超过此范围的整数值在赋值、运算、转字符串时都会丢失精度。

## 精度丢失示例

```ts
// 直接赋值：超出安全整数范围，末位被截断
let wrong = 1637034321724565504;       // 实际变成 1637034321724565504（可能已不精确）
console.log(wrong);                    // 末位可能偏离原始值

// 直接运算：JS number 精度不足
let wrongSum = 1637034321724565504 + 1; // 结果可能不等于 1637034321724565505
```

## 禁止写法

- 将 Java 返回的 Long/BigInt ID 直接赋值给 JS `number` 变量
- 对超出安全整数范围的值做 `Number()` 转换
- 对超出安全整数范围的值做 `parseFloat()` / `parseInt()` 转换
- 用 `` `${bigintValue}` `` 或 `String(bigintValue)` 对未包装的值转字符串（精度已丢失，字符串也是错的）
- `BigInt` 与 `number` 混合运算（如 `bigIntVar + 1`，会报 TypeError）

## 正确写法：BigInt 声明与运算

### 声明 BigInt 的三种方式

```ts
// 方式一：数字字面量后缀 n（适合已知精确值的字面量）
let id1 = 1637034321724565504n;

// 方式二：BigInt() 构造器传入数字（注意：传入的数字本身不能超出安全整数范围）
let id2 = BigInt(1637034321724565505);

// 方式三：BigInt() 构造器传入字符串（推荐，适合从外部获取的大整数字符串）
let id3 = BigInt("1637034321724565506");
```

> **推荐方式三**：从 Java 端获取的大整数 ID，先转字符串再用 `BigInt("...")` 包装，避免中间步骤精度丢失。

### BigInt 运算规则

```ts
let id1 = 1637034321724565504n;
let id2 = BigInt(1637034321724565505);
let id3 = BigInt("1637034321724565506");

// 加法
let v1 = id1 + id2 + id3;
console.log(v1);  // 输出: 4911102965173696515n

// 乘法（乘数也必须是 BigInt 类型，加 n 后缀）
let v2 = id1 * 2n;
console.log(v2);  // 输出: 3274068643449131008n

// 除法（除数也必须是 BigInt 类型，结果截断为整数）
let v3 = id3 / 3n;
console.log(v3);  // 输出: 545678107241521835n
```

**运算规则：BigInt 只能与 BigInt 运算，不能与 number 混合运算。**

## QFilter 查询中使用 BigInt

Java 返回的主键字段（如 `id`、`PkValue`）在 QFilter 查询中必须以 `BigInt` 形式传入，否则精度丢失导致查不到数据：

```ts
import { BusinessDataServiceHelper } from '@cosmic/bos-core/kd/bos/servicehelper'
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query"

// 正确：用 BigInt 包装后作为 QFilter 值
let id = BigInt("1637034321724565504");
let data = BusinessDataServiceHelper.loadSingle(
  "bos_user",
  "id",
  [new QFilter("id", "=", id)]
);

// 读取返回值的主键，也必须用 BigInt 包装
let pk = BigInt(data.getPkValue());
```

## 从 DynamicObject 读取大整数 ID

```ts
// 禁止：直接转 number
// let id = Number(row.get('id'));       // 精度丢失

// 正确：先转字符串，再用 BigInt 包装
const rawId = row.get('id');
const idStr = rawId === null || rawId === undefined ? '' : `${rawId}`;
const id = idStr !== '' ? BigInt(idStr) : 0n;
```

> **注意**：此处的 `` `${rawId}` `` 之所以安全，是因为 `rawId` 来自 Java 端，运行时对其 `toString()` 的结果是精确的。但如果你从 JS 字面量赋值就已经丢失精度，那转字符串也没用。

## 适用场景

- 主键 ID 的查询、比较、存储
- Long 类型字段的读取与运算
- 任何超过 JS 安全整数范围（±9007199254740991）的整数值

## 输出前自检

- 是否将 Java 返回的 Long/BigInt ID 直接赋值给了 JS `number` 变量？
- 是否用 `Number()` / `parseFloat()` / `parseInt()` 转换了大整数值？
- QFilter 查询中的 ID 值是否已用 `BigInt()` 包装？
- `DynamicObject.getPkValue()` / `row.get('id')` 的返回值是否已用 `BigInt()` 包装？
- BigInt 运算中是否混用了 `number` 类型？（应全部用 `BigInt` + `n` 后缀）
