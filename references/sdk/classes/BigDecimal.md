# BigDecimal

## 基本信息

- 名称：`BigDecimal`
- Java 类名：`java.math.BigDecimal`
- TS 导出名：`BigDecimal`
- 所属模块：`@cosmic/bos-script`
- 所属包：`java`
- 命名空间：`java.math`
- 类型：高精度金额与数值对象
- 来源：
  - TS 声明：`@cosmic/bos-script/index.d.ts`
  - Javadoc：待补充

## 用途概述

用于在 Kingscript 中处理金额、税额、汇率、数量等高精度数值，避免直接用 JavaScript `number` 带来的精度误差。

## 典型场景

- 金额相加、相减、乘除
- 比较金额大小
- 控制小数位与舍入方式
- 计算税额、折扣率、汇率后再回写模型

## 用户常见问法

- 金额为什么不能直接加减
- `BigDecimal.ZERO` 怎么用
- 两个金额怎么比较大小
- `setScale` 什么时候用

## 常见搭配

- `AbstractBillPlugIn`
  - 在单据计算逻辑中处理金额
- `AbstractValidator`
  - 校验金额是否大于零、是否超限
- `Date`
  - 经常与日期一起参与期间或有效期判断

## 高频方法

- `valueOf(...)`
- `add(...)`
- `subtract(...)`
- `multiply(...)`
- `divide(...)`
- `compareTo(...)`
- `setScale(...)`
- `toPlainString()`
- `stripTrailingZeros()`

## 高频常量

- `BigDecimal.ZERO`
- `BigDecimal.ONE`
- `BigDecimal.TEN`

## 高价值规则

- 金额、税额、汇率这类字段优先使用 `BigDecimal` 运算
- 比较大小优先用 `compareTo(...)`，不要直接按 JS 数值比较
- 展示给用户前，再决定是否 `setScale(...)` 或转字符串

## 运行时注意事项

- `BigDecimal` 是 Java 运行时对象，不是 JS 原生数字
- `divide(...)` 涉及精度和舍入时，要明确小数位或舍入策略
- 编辑器里看起来像普通对象，运行时仍要按 Java 数值对象来处理

## 常见错误

### 1. 直接用 `+`、`-` 处理金额

高概率原因：
- 把高精度对象当成了 JS `number`
- 忽略了金额字段的精度要求

## 相关文档

- [AbstractBillPlugIn.md](AbstractBillPlugIn.md)
- [AbstractValidator.md](AbstractValidator.md)
- troubleshooting.md

## 关键词

- 中文关键词：金额、高精度、小数精度、金额比较、舍入
- 英文关键词：`BigDecimal`
- 常见报错词：精度丢失、金额比较错误
