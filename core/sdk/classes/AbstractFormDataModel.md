# AbstractFormDataModel

## 基本信息

- 名称：`AbstractFormDataModel`
- Java 类名：`kd.bos.entity.datamodel.AbstractFormDataModel`
- TS 导出名：`AbstractFormDataModel`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity`
- 命名空间：`kd.bos.entity.datamodel`
- 类型：表单数据模型抽象基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/entity/datamodel.d.ts`
  - Javadoc：待补充

## 用途概述

用于承接表单与单据数据模型的共性能力，是 `this.getModel()` 背后更底层的数据模型抽象。

## 典型场景

- 理解字段取值、赋值、分录操作的数据模型来源
- 区分页面视图与数据模型职责
- 理解 `IBillModel`、`IDataModel` 等接口的抽象层

## 用户常见问法

- `getModel()` 背后是什么
- 为什么字段值修改会影响事件触发
- 数据模型和视图的区别是什么

## 常见搭配

- `IDataModel`
- `IBillModel`
- `FormDataModel`
- `this.getModel()`

## 高价值规则

- 数据模型负责数据读写和事件联动，不负责页面展示
- 很多联动、脏数据、事件触发问题，本质上都与数据模型有关
- 修改模型值时要注意是否引起新的事件链路

## 运行时注意事项

- 数据模型与页面视图是两条不同主线
- 在事件中频繁修改模型值，可能引起联动循环或脏数据提示

## 相关文档

- [AbstractBillPlugIn.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractBillPlugIn.md)
- [AbstractFormPlugin.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractFormPlugin.md)
- [troubleshooting.md](/E:/kingscript%20skills/kingscript-skill/core/docs/troubleshooting.md)

## 关键词

- 中文关键词：数据模型、表单模型、`getModel`
- 英文关键词：`AbstractFormDataModel`
- 常见报错词：脏数据、事件循环、模型赋值异常
