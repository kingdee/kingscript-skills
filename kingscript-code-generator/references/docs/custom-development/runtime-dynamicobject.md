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

## 读取后处理原则

1. 先读取：`row.get('fieldKey')`
2. 再转字符串
3. 再转数值（如确有需要）
4. 不直接深层链式访问

## 输出前自检

- 是否统一使用了 `row.get('fieldKey')`？
- 是否出现 `row?.get?.(...)`？
- 是否先取值再显式转换，而不是链式处理？
