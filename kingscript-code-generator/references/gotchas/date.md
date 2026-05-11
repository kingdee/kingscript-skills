# Date 桥接与过滤风险说明

## 风险说明

KingScript 中的 `Date` 是对 Java `Date` 对象的封装，不应默认视为与 JS `Date` 完全等价。

### 运算符比较失效

KingScript 中 `Date` 对象**无法通过运算符 `>` `<` `<=` `>=` `==` 进行比较**，比较结果不符合预期：

```ts
let date1: Date = new Date("2024-12-01");
let date2: Date = new Date("2025-01-01");
console.log(date1 <= date2);
// false — 预期应为 true，但运算符比较不适用于 Java Date 封装
```

**正确写法**：通过 `compareTo()` 方法或 `getTime()` 后比较：

```ts
let date1: Date = new Date("2024-12-01");
let date2: Date = new Date("2025-01-01");

// 方式一：compareTo（推荐）
console.log(date1.compareTo(date2) < 0);  // true

// 方式二：getTime 后数值比较
console.log(date1.getTime() < date2.getTime());  // true
```

| 比较意图 | 错误写法 | 正确写法 |
|---------|---------|----------|
| date1 < date2 | `date1 < date2` | `date1.compareTo(date2) < 0` |
| date1 > date2 | `date1 > date2` | `date1.compareTo(date2) > 0` |
| date1 == date2 | `date1 == date2` | `date1.compareTo(date2) == 0` |
| date1 <= date2 | `date1 <= date2` | `date1.compareTo(date2) <= 0` |

### `getDay()` 返回值范围不同

KingScript 中 `Date.getDay()` 底层映射的是 Java `Calendar.get(Calendar.DAY_OF_WEEK)`，返回值范围是 **1 ~ 7**，而非 JS 的 **0 ~ 6**。

```ts
// 假设今天是周四
const date = new Date();

// JS Date.getDay()  → 返回 4（0~6，0=Sunday）
// KingScript getDay() → 返回 5（1~7，1=Sunday）
```

| 语言 | 方法/映射 | 返回范围 | 星期日 | 星期一 | 星期四 | 星期六 |
|------|----------|---------|--------|--------|--------|--------|
| JavaScript | `Date.getDay()` | 0 ~ 6 | 0 | 1 | 4 | 6 |
| KingScript/Java | `Calendar.DAY_OF_WEEK` | 1 ~ 7 | 1 | 2 | 5 | 7 |

**影响**：如果按 JS 习惯用 `getDay()` 做星期判断（如 `getDay() === 0` 判断周日），在 KingScript 中会永远不成立。

**正确写法**：按 1~7 范围处理，或显式偏移：

```ts
const day = date.getDay();  // KingScript 返回 1~7

// 判断周日：
if (day === 1) { /* 周日 */ }

// 判断工作日（周一~周五）：
if (day >= 2 && day <= 6) { /* 工作日 */ }

// 如需对齐 JS 0~6 习惯，显式偏移：
const jsDay = day - 1;  // 转为 0~6
```

## 高风险写法

- 使用运算符 `>` `<` `<=` `>=` `==` 比较 Date 对象（结果不符合预期，应用 `compareTo()` 或 `getTime()`）
- 按 JS 0~6 范围使用 `getDay()` 返回值（KingScript 实际返回 1~7）
- `setHours` / `setMinutes` / `setSeconds` 叠加复杂逻辑
- 复杂日期偏移后直接作为 `QFilter` 入参
- 假设时区和格式化结果在运行时完全一致

## 推荐策略

- 优先使用 `SimpleDateFormat` 做展示和分组
- 复杂过滤优先复用已验证模板
- 无成熟模板时，先做较宽查询，再在脚本中聚合

## `row.getDate(field)` 不可捕获异常风险

> **禁止直接使用 `row.getDate(field)`**，某些字段类型会抛不可捕获异常导致 HTTP 500 空响应体，catch 接不住。

- 原因：`getDate()` 在某些字段类型上触发的异常发生在 KS 运行时深层，无法被脚本层 catch 捕获
- 替代方案：先用 `row.get(field)` 取值，再转字符串做安全解析

```ts
// 禁止
const date = row.getDate('bizdate');

// 正确：先取字符串再解析
const dateStr = row.get('bizdate');
const text = dateStr === null || dateStr === undefined ? '' : `${dateStr}`;
// 如需提取年月，根据实际格式做正则解析
const match = text.match(/(\d{4})-(\d{1,2})/);
const year = match ? match[1] : '';
const month = match ? match[2] : '';
```

详见 `README.md` 坑 14。

## 输出前自检

- 是否用运算符 `>` `<` 比较了 Date 对象？（应改用 `compareTo()` 或 `getTime()`）
- 是否按 JS 0~6 范围使用了 `getDay()` 返回值？（KingScript 实际返回 1~7，周日=1）
- 是否把 Java Date 当作 JS Date 做了复杂运算？
- 是否对时区和格式化做了未经验证的假设？
- 是否可以用"宽查询 + 脚本内聚合"替代复杂过滤？
- 是否避免了 `row.getDate()` 而改用 `row.get()` + 字符串解析？
