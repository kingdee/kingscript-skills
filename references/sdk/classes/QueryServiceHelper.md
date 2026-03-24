# QueryServiceHelper

## 基本信息

- 名称：`QueryServiceHelper`
- Java 类名：`kd.bos.servicehelper.QueryServiceHelper`
- TS 导出名：`QueryServiceHelper`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.servicehelper`
- 类型：查询服务助手类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/servicehelper.d.ts`
  - Javadoc：待补充

## 用途概述

用于执行查询类操作，常见于查询单值、单条记录、多条记录或配合业务逻辑做只读判断。

## 典型场景

- 根据主键查询单条记录
- 查询供应商、用户、状态等基础信息
- 在单据打开、字段联动、保存前校验中做只读查询

## 用户常见问法

- 怎么查一条数据
- `queryOne` 怎么用
- 为什么查出来是空
- 查询辅助类和业务数据助手有什么区别

## 常见搭配

- `QFilter`
- `QCP`
- `DynamicObject`

## 高价值规则

- 查询前先明确是“只读查询”还是“业务对象加载”
- 先把字段清单和过滤条件缩小到最小可验证集
- 查询结果为空时，优先回头检查上下文和过滤条件

## 示例代码

### 场景 1：查询一条用户数据

```kingscript
let user = QueryServiceHelper.queryOne(
  "bos_user",
  "id,name,enable",
  [new QFilter("id", "=", 10001)]
);
```

### 场景 2：在单据加载后查询供应商信用状态

```kingscript
let creditObj = QueryServiceHelper.queryOne(
  "bd_supplier",
  "creditstatus,creditlimit",
  [new QFilter("id", QCP.equals, supplierId)]
);
```

## 运行时注意事项

- 查询服务适合做读取，不适合把它理解成任意对象操作入口
- 查询结果对象通常仍然带有平台对象语义
- 如果字段精度、日期、集合类型参与后续处理，要继续按 Kingscript 运行时规则处理

## 常见错误

### 1. 查询为空

高概率原因：
- 过滤条件不匹配
- 查询字段名写错
- 组织、租户、账套、上下文影响结果

### 2. 查询后继续处理时报类型异常

高概率原因：
- 把返回对象当作原生 JS 对象使用
- 与 `BigInt`、`Date`、序列化相关类型混用

## 相关文档

- [QFilter.md](QFilter.md)
- [BusinessDataServiceHelper.md](BusinessDataServiceHelper.md)
- troubleshooting.md

## 关键词

- 中文关键词：查询服务、查一条、查单值、只读查询
- 英文关键词：`QueryServiceHelper`、`queryOne`
- 常见报错词：查不到、空对象、过滤条件错误
