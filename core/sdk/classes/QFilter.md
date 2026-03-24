# QFilter

## 基本信息

- 名称：`QFilter`
- Java 类名：`kd.bos.orm.query.QFilter`
- TS 导出名：`QFilter`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/orm`
- 命名空间：`kd.bos.orm.query`
- 类型：查询过滤条件类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/orm/query.d.ts`
  - Javadoc：待补充

## 用途概述

用于构造查询过滤条件，常与 `BusinessDataServiceHelper`、`QueryServiceHelper`、`QCP` 搭配使用。

## 典型场景

- 按主键、编码、状态查询业务数据
- 构造 `=`、`like`、`in` 等条件
- 多个条件组合后传给查询服务
- 在插件中根据用户输入动态拼接查询条件

## 用户常见问法

- 过滤条件怎么写
- `in` 查询怎么写
- `QFilter` 为什么会类型转换错误
- 查询服务的 filters 应该传什么

## 常见搭配

- `QCP`
  - 用于表示比较操作符，如 `equals`、`in`
- `BusinessDataServiceHelper`
  - 常用于加载业务对象
- `QueryServiceHelper`
  - 常用于查询单条或多条数据
- `ArrayList`
  - 在 `in` 这类场景下，单个 `QFilter` 内部往往需要 Java 集合类型

## 高价值规则

- 单个 `QFilter` 内部的参数，要优先按运行时要求准备类型
- 多个 `QFilter` 组合时，外层通常使用 TypeScript 数组
- `in` 场景不要默认传 JS 原生数组，优先检查是否应使用 `ArrayList`
- 编辑器类型通过，不代表运行时类型一定兼容

## 示例代码

### 场景 1：简单等值查询

```kingscript
let filters = [];
filters.push(new QFilter("id", "=", 10001));
let data = BusinessDataServiceHelper.loadSingle("bos_user", "id,name", filters);
```

### 场景 2：`in` 查询

```kingscript
let filters = [];
let list = new ArrayList();
list.add("CNY");
list.add("USD");
filters.push(new QFilter("number", QCP.in, list));
let datas = BusinessDataServiceHelper.load("bd_currency", "name", filters);
```

## 运行时注意事项

- `QFilter` 是运行时强相关类型，重点不是“能不能写出来”，而是“传进去的值类型对不对”
- 过滤字段名、实体名、比较操作符和值类型需要同时匹配
- 对于集合型参数，优先参考已有 FAQ 和示例，不要自由猜测

## 常见错误

### 1. `QFilter` 类型转换错误

常见现象：
- 运行时报类型转换异常
- 查询条件看起来没问题，但服务执行失败

高概率原因：
- `in` 条件值传成了不兼容的 JS 类型
- 把 Java 容器和 TS 数组的使用层级搞反了

建议排查顺序：
1. 检查单个 `QFilter` 内部的值是否需要 Java 类型
2. 检查外层 filters 是否是数组
3. 检查操作符和参数类型是否匹配

## 相关文档

- [BusinessDataServiceHelper.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/BusinessDataServiceHelper.md)
- [QueryServiceHelper.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/QueryServiceHelper.md)
- [troubleshooting.md](/E:/kingscript%20skills/kingscript-skill/core/docs/troubleshooting.md)
- [4.4.9QFilter类型转换错误.md](/E:/kingscript%20skills/kingscript-skill/core/docs/common-issues/4.4%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98/4.4.9QFilter%E7%B1%BB%E5%9E%8B%E8%BD%AC%E6%8D%A2%E9%94%99%E8%AF%AF.md)

## 关键词

- 中文关键词：过滤条件、条件构造、查询条件、`in` 查询
- 英文关键词：`QFilter`、`QCP`、filter
- 常见报错词：类型转换错误、QFilter 转换失败
