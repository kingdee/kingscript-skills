# 数值类型运行时处理约定（BigDecimal / Long / BigInt）

Java 端返回的数值对象（`BigDecimal` / `Long` / `BigInteger`）在 KingScript 运行时不是原生 JS `number`。直接按 JS 数值处理会出现两类问题：

- 金额/BigDecimal：类型判断、格式化、算术行为与原生 `number` 不一致
- 大整数 ID/Long：JS `number` 基于 IEEE 754 双精度浮点，安全整数范围 ±2⁵³-1（±9007199254740991），超出即丢精度

本文档分两节给出各自的禁止写法与推荐写法。

---

## 一、BigDecimal / 金额字段

### 风险

`QueryServiceHelper.query` 或 `DynamicObject.get` 返回的金额、数值字段常见为 Java `BigDecimal`，不是 JS `number`。

### 禁止写法

- `Number(value)`
- `Number.isFinite(value)`
- `value.toFixed(...)`
- `value + 1` 这类隐式数值运算

### 推荐写法

```ts
function toSafeNumber(value: any): number {
  if (value === null || value === undefined || value === '') {
    return 0;
  }
  const text = `${value}`;
  const num = parseFloat(text);
  return isNaN(num) ? 0 : num;
}
```

### 适用场景

- 汇总金额、图表金额、统计卡片金额
- 任何非大整数范围的 BigDecimal 字段

### 自检

- 是否对 BigDecimal 直接做了 `Number()` / `toFixed()` / `Number.isFinite()`？
- 是否先字符串化、再 `parseFloat`、再 `isNaN` 兜底？

---

## 二、Long / BigInteger / 大整数 ID

### 风险

Java 端返回的 `Long` / `BigInteger` 类型 ID（主键 `id`、`PkValue` 等），超出 JS 安全整数范围后，赋值、运算、转字符串都会丢失精度。

### 精度丢失示例

```ts
// 直接赋值：超出安全整数范围，末位被截断
let wrong = 1637034321724565504;       // 末位可能偏离原始值

// 直接运算：JS number 精度不足
let wrongSum = 1637034321724565504 + 1; // 结果可能不等于 1637034321724565505
```

### 禁止写法

- 将 Java 返回的 Long/BigInt ID 直接赋值给 JS `number` 变量
- 对超出安全整数范围的值做 `Number()` 转换
- 对超出安全整数范围的值做 `parseFloat()` / `parseInt()` 转换
- 用 `` `${bigintValue}` `` 或 `String(bigintValue)` 对**未包装**的值转字符串（精度已丢失，字符串也是错的）
- `BigInt` 与 `number` 混合运算（如 `bigIntVar + 1`，会报 TypeError）

### BigInt 声明

```ts
// 方式一：字面量后缀 n（适合已知精确值的字面量）
let id1 = 1637034321724565504n;

// 方式二：BigInt(数字)（传入数字本身不能超出安全整数范围）
let id2 = BigInt(1637034321724565505);

// 方式三：BigInt("字符串")（推荐，适合外部大整数字符串）
let id3 = BigInt("1637034321724565506");
```

> **推荐方式三**：从 Java 端获取的大整数 ID，先转字符串再 `BigInt("...")`，避免中间步骤精度丢失。

### BigInt 运算规则

```ts
let id1 = 1637034321724565504n;
let id2 = BigInt(1637034321724565505);
let id3 = BigInt("1637034321724565506");

// 加法
let v1 = id1 + id2 + id3;               // 4911102965173696515n

// 乘法：乘数也必须是 BigInt，加 n 后缀
let v2 = id1 * 2n;                      // 3274068643449131008n

// 除法：除数必须是 BigInt，结果截断为整数
let v3 = id3 / 3n;                      // 545678107241521835n
```

**运算规则：BigInt 只能与 BigInt 运算，不能与 number 混合。**

### QFilter 查询中使用 BigInt

Java 主键字段（`id`、`PkValue`）在 QFilter 查询中必须以 `BigInt` 形式传入，否则精度丢失查不到数据：

```ts
import { BusinessDataServiceHelper } from '@cosmic/bos-core/kd/bos/servicehelper'
import { QFilter } from '@cosmic/bos-core/kd/bos/orm/query'

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

### 从 DynamicObject 读取大整数 ID

```ts
// 禁止：直接转 number
// let id = Number(row.get('id'));

// 正确：先转字符串，再 BigInt 包装
const rawId = row.get('id');
const idStr = rawId === null || rawId === undefined ? '' : `${rawId}`;
const id = idStr !== '' ? BigInt(idStr) : 0n;
```

> `` `${rawId}` `` 在此处安全，是因为 `rawId` 来自 Java 端，运行时 `toString()` 结果精确。如果你从 JS 字面量赋值就已经丢了精度，转字符串也救不回来。

### 适用场景

- 主键 ID 的查询、比较、存储
- Long 类型字段的读取与运算
- 任何超过 JS 安全整数范围（±9007199254740991）的整数值

### 自检

- 是否将 Java 返回的 Long/BigInt ID 直接赋值给了 JS `number` 变量？
- 是否用 `Number()` / `parseFloat()` / `parseInt()` 转换了大整数值？
- QFilter 查询中的 ID 值是否已用 `BigInt()` 包装？
- `DynamicObject.getPkValue()` / `row.get('id')` 返回值是否已用 `BigInt()` 包装？
- BigInt 运算中是否混用了 `number` 类型？（应全部用 `BigInt` + `n` 后缀）
