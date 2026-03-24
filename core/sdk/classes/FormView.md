# FormView

## 基本信息

- 名称：`FormView`
- Java 类名：`kd.bos.mvc.form.FormView`
- TS 导出名：`FormView`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/mvc`
- 命名空间：`kd.bos.mvc.form`
- 类型：表单视图实现类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/mvc/form.d.ts`
  - Javadoc：待补充

## 用途概述

`FormView` 是表单视图的具体实现类，位于 MVC 体系中，通常用于理解表单页面的实现层结构。

## 典型场景

- 理解表单视图的 MVC 实现层
- 在更底层的视图、控制器、模型关系里定位能力归属
- 区分接口 `IFormView`、抽象类 `AbstractFormView` 与具体实现 `FormView`

## 使用建议

- 一般二开脚本里更常直接接触的是 `IFormView`
- `FormView` 更适合在理解框架分层、排查底层视图行为时使用
- 如果问题只是“怎么弹消息”“怎么更新控件”，优先看 `IFormView`

## 常见搭配

- `IFormView`
- `AbstractFormView`
- `FormDataModel`
- `FormController`

## 高价值规则

- 接口、抽象类、实现类三者职责不同：
  - `IFormView` 偏能力接口
  - `AbstractFormView` 偏抽象基类
  - `FormView` 偏 MVC 实现类
- 做业务二开时，不要一上来就钻到实现层

## 相关文档

- [IFormView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/IFormView.md)
- [AbstractFormView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractFormView.md)
- [AbstractFormDataModel.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractFormDataModel.md)

## 关键词

- 中文关键词：表单视图实现、MVC 表单视图
- 英文关键词：`FormView`
- 常见报错词：视图实现层、MVC 表单
