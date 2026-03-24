# BusinessDataServiceHelper

## 基本信息

- 名称：`BusinessDataServiceHelper`
- Java 类名：`kd.bos.servicehelper.BusinessDataServiceHelper`
- TS 导出名：`BusinessDataServiceHelper`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.servicehelper`
- 类型：业务数据服务助手类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/servicehelper.d.ts`
  - Javadoc：待补充

## 用途概述

用于按实体、字段和过滤条件加载业务对象，是 Kingscript 二开中最常见的数据加载入口之一。

## 典型场景

- 按单据主键或编码加载单据
- 在联动逻辑中查询基础资料
- 在按钮、表单、单据插件中按条件取业务数据
- 配合 `QFilter` 执行精确查询或范围查询

## 用户常见问法

- 怎么查单据
- 怎么按条件加载业务对象
- `load` 和 `loadSingle` 怎么用
- 查询为什么查不到数据

## 常见搭配

- `QFilter`
  - 用于构造过滤条件
- `QCP`
  - 用于表示比较操作符
- `DynamicObject`
  - 用于承载返回的业务对象

## 高价值规则

- 先确认实体标识、字段名、过滤条件三者是否一致
- 先在最小查询场景里验证一条条件，再叠加复杂条件
- 加载到的数据通常是运行时业务对象，不要把它当成普通 JS 对象使用

## 示例代码

### 场景 1：按条件加载单条数据

```kingscript
let filters = [];
filters.push(new QFilter("id", "=", 10001));
let data = BusinessDataServiceHelper.loadSingle("bos_user", "id,name", filters);
```

### 场景 2：按条件加载多条数据

```kingscript
let filters = [];
filters.push(new QFilter("number", "=", "CNY"));
let datas = BusinessDataServiceHelper.load("bd_currency", "id,name,number", filters);
```

## 运行时注意事项

- 返回对象、过滤参数和值类型都带有明显的 Java 运行时语义
- 如果查不到数据，不一定是服务有问题，也可能是实体名、字段名、过滤值或上下文不对
- 如果使用长整型主键，要特别关注 `BigInt` 和数值精度问题

## 常见错误

### 1. 查询条件可写但运行时报错

高概率原因：
- `QFilter` 参数类型不对
- `in` 条件值集合类型错误
- 过滤字段名和实体字段不匹配

### 2. 明明有数据却查不到

高概率原因：
- 过滤值类型和真实字段类型不一致
- 上下文、组织、租户或业务场景导致结果被隔离

## 相关文档

- [QFilter.md](QFilter.md)
- [QueryServiceHelper.md](QueryServiceHelper.md)
- 4.4.4长整型精度丢失.md
- 4.4.9QFilter类型转换错误.md

## 关键词

- 中文关键词：查单据、查资料、加载业务对象、按条件查询
- 英文关键词：`BusinessDataServiceHelper`、`load`、`loadSingle`
- 常见报错词：查询不到、类型转换错误、主键精度异常
