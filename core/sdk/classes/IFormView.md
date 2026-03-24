# IFormView

## 基本信息

- 名称：`IFormView`
- Java 类名：`kd.bos.form.IFormView`
- TS 导出名：`IFormView`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.form`
- 类型：表单视图接口
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/form.d.ts`
  - Javadoc：待补充

## 用途概述

用于表示表单页面视图接口，是 Kingscript 表单、单据、控件、页面交互能力的核心入口之一。

## 典型场景

- 通过 `this.getView()` 获取当前页面视图
- 弹提示、通知、消息框
- 控件启用、禁用、刷新、更新
- 页面缓存、打开页面、关闭页面、定时器等页面级操作

## 用户常见问法

- `getView()` 返回的是什么
- 页面上弹消息用什么对象
- 怎么控制控件状态
- 页面缓存和页面操作该从哪里进

## 常见搭配

- `AbstractFormPlugin`
- `AbstractBillPlugIn`
- `this.getView()`
- `this.getModel()`

## 高价值规则

- `IFormView` 更像“页面能力入口接口”，不是具体业务插件
- 绝大多数页面交互问题，都会落到 `getView()` 提供的能力上
- 它偏页面和控件操作，不等于数据模型对象

## 运行时注意事项

- 先区分页面视图能力和数据模型能力，不要把 `view` 和 `model` 混用
- 某些页面生命周期阶段，控件尚未绑定或已释放，不能想当然操作页面元素

## 相关文档

- [AbstractFormPlugin.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractFormPlugin.md)
- [AbstractBillPlugIn.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractBillPlugIn.md)
- [3.1调试KingScript.md](/E:/kingscript%20skills/kingscript-skill/core/docs/debugging/3.1%E8%B0%83%E8%AF%95KingScript.md)

## 关键词

- 中文关键词：表单视图、页面视图、页面对象、`getView`
- 英文关键词：`IFormView`
- 常见报错词：视图为空、控件未绑定、页面操作无效
