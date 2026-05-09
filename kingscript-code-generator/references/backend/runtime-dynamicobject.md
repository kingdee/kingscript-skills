# DynamicObject 读取规范

## 推荐写法

```ts
const statusValue = row.get('billstatus');
const status = statusValue === null || statusValue === undefined ? '' : `${statusValue}`;
```

## 禁止默认写法

```ts
const status = row?.get?.('billstatus');
```

## 日期字段读取约束

> 禁止直接使用 `row.getDate(field)`，某些字段类型会抛不可捕获异常导致 HTTP 500 空响应体，catch 接不住。

- 错误写法：`const date = row.getDate('bizdate')`
- 正确写法：先用 `row.get(field)` 取值，再转字符串安全解析

```ts
const dateStr = row.get('bizdate');
const text = dateStr === null || dateStr === undefined ? '' : `${dateStr}`;
```

详见 `runtime-date-bridge.md` 和 `faq-runtime-pitfalls.md` 坑 11。

## 字段名校验原则

查询字段名必须与实体元数据定义严格匹配：

- 拼写错误或不存在的字段名会导致服务端异常，且异常不可被脚本层捕获，直接 HTTP 500 空响应体
- **开发前必须对照实体元数据确认字段清单**，明确 header 字段和 entry 字段分类，不可猜测
- 分录字段必须带分录标识前缀（如 `entryentity.kdtest_field`），单头字段不带前缀

## 读取后处理原则

1. 先读取：`row.get('fieldKey')`
2. 再转字符串
3. 再转数值（如确有需要）
4. 不直接深层链式访问
5. 日期字段禁止 `getDate()`，统一用 `getString` 后安全解析

## 输出前自检

- 是否统一使用了 `row.get('fieldKey')`？
- 是否出现 `row?.get?.(...)`？
- 是否先取值再显式转换，而不是链式处理？
- 日期字段是否避免了 `row.getDate()`？
- 字段名是否已对照实体元数据确认，不存在拼写错误？
