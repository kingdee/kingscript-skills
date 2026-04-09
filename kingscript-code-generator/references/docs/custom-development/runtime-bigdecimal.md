# BigDecimal 运行时处理约定

## 风险说明

`QueryServiceHelper.query` 或 `DynamicObject.get` 返回的金额/数值字段，运行时常见为 Java BigDecimal，而不是原生 JS `number`。

## 禁止写法

- `Number(value)`
- `Number.isFinite(value)`
- `value.toFixed(...)`
- `value + 1` 这类隐式数值运算

## 推荐写法

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

## 适用场景

- 汇总金额
- 图表金额
- 统计卡片金额

## 输出前自检

- 是否对 BigDecimal 直接做了 `Number()/toFixed()/Number.isFinite()`？
- 是否先做了字符串化，再 `parseFloat`，再 `isNaN` 兜底？
