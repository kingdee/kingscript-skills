# QCP

## 基本信息

- 名称：`QCP`
- Java 类名：`kd.bos.orm.query.QCP`
- TS 导出名：`QCP`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/orm`
- 命名空间：`kd.bos.orm.query`
- 类型：查询比较符常量集合
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-ormengine.d.ts`
  - Javadoc：待补充

## 用途概述

用于给 `QFilter` 提供比较操作符，是构造查询条件时的高频配套对象。

## 典型场景

- 等值、非等值、包含、不包含条件
- `in`、`not in` 查询
- 大于、小于、大于等于、小于等于比较
- 和 `QFilter` 组合构造复杂过滤条件

## 用户常见问法

- `QCP.in` 是什么
- `equals` 和直接写 `=` 有什么区别
- 比较符应该写字符串还是写 `QCP`

## 常见搭配

- `QFilter`
  - 负责承载字段、比较符和值
- `BusinessDataServiceHelper`
  - 按条件加载业务对象
- `QueryServiceHelper`
  - 按条件查询单条或多条数据

## 高频常量

- `equals`
- `not_equals`
- `large_than`
- `large_equals`
- `less_than`
- `less_equals`
- `in`
- `not_in`

## 高价值规则

- 优先把 `QCP` 当成比较符常量入口，而不是随手写字符串
- `in`、`not in` 这类场景不仅要比较符对，还要值类型对
- 比较符写对了，不代表参数类型就一定正确

## 运行时注意事项

- 某些查询能否成功，不只取决于比较符，还取决于字段类型和传值类型
- `QCP` 解决的是“怎么比较”，不是“怎么构造参数”

## 常见错误

### 1. `QCP.in` 搭配 JS 数组直接运行报错

高概率原因：
- 只看到了比较符，忽略了 `QFilter` 对参数类型的要求

## 相关文档

- [QFilter.md](QFilter.md)
- [BusinessDataServiceHelper.md](BusinessDataServiceHelper.md)
- [QueryServiceHelper.md](QueryServiceHelper.md)

## 关键词

- 中文关键词：比较符、查询操作符、等于、不等于、in、not in
- 英文关键词：`QCP`
- 常见报错词：操作符不匹配、比较符不对
