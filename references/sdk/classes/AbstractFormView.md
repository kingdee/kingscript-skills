# AbstractFormView

## 基本信息

- 名称：`AbstractFormView`
- Java 类名：`kd.bos.form.AbstractFormView`
- TS 导出名：`AbstractFormView`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.form`
- 类型：表单视图抽象基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/form.d.ts`
  - Javadoc：待补充

## 用途概述

用于承接表单视图的共性行为，是 `IFormView` 和具体视图实现之间的重要抽象层。

## 典型场景

- 理解表单视图能力来自哪一层
- 排查页面级能力在抽象基类还是具体实现类
- 衔接 `IFormView` 与 `FormView`

## 使用建议

- 二开脚本直接操作时，一般仍以 `IFormView` 为主要认知入口
- 当需要理解“为什么这些视图能力在表单和单据里都能用”时，再看 `AbstractFormView`

## 常见搭配

- `IFormView`
- `FormView`
- `AbstractFormPlugin`

## 高价值规则

- 它是视图抽象层，不是业务插件基类
- 如果问题偏页面能力归属，读它有价值；如果问题偏业务插件事件，优先看插件基类

## 相关文档

- [IFormView.md](IFormView.md)
- [FormView.md](FormView.md)
- [AbstractFormPlugin.md](AbstractFormPlugin.md)

## 关键词

- 中文关键词：表单视图抽象基类、抽象视图
- 英文关键词：`AbstractFormView`
- 常见报错词：视图抽象层、页面能力来源
