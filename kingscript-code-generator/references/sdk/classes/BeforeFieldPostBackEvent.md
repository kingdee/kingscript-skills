# BeforeFieldPostBackEvent

## 基本信息

- 名称：`BeforeFieldPostBackEvent`
- Java 类名：`kd.bos.form.events.BeforeFieldPostBackEvent`
- TS 导出名：`BeforeFieldPostBackEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：字段回传前事件参数
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/events` 相关声明核对
  - 相关示例：[beforeFieldPostBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于客户端字段值变化准备回传服务器之前的拦截和控制，常见于录单性能优化和非关键字段回传裁剪。

## 典型场景

- 备注、说明类字段变化不回传服务器
- 关键联动字段仍保持正常回传
- 按字段 key、当前行和当前值决定是否取消回传

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getKey` | 获取控件或字段标识 | 无 | `String` | 判断当前回传字段 |
| `getValue` | 获取本次值 | 无 | `Object` | 可按值做轻量判断 |
| `getRowIndex` | 获取实体行号 | 无 | `int` | 分录字段常用 |
| `getParentRowIndex` | 获取父实体行号 | 无 | `int` | 多级分录时使用 |
| `setCancel` | 取消回传 | `boolean` | `void` | `true` 后服务端对应联动不会触发 |

## 运行时注意事项

- 取消回传后，服务端 `propertyChanged` 不会针对该字段触发。
- 只适合对纯录入、纯展示字段做裁剪，不要误伤联动计算字段。
- 该事件关注的是“是否回传”，不是“是否保存”；保存时字段值仍可能整体提交。

## 常见搭配

- 搭配类：`AbstractFormPlugin`
- 搭配示例：[beforeFieldPostBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md)
- 搭配 FAQ：
  - 字段回传怎么关掉
  - 为啥关掉后联动不跑了

## 常见错误

### 1. 取消了关键字段回传

高概率原因：
- 只按字段类型判断，没有看业务联动
- 没梳理服务端依赖关系

### 2. 以为取消回传等于取消保存

高概率原因：
- 混淆了页面交互阶段和最终保存阶段

## 相关示例

- [beforeFieldPostBack.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeFieldPostBack.md)

## 关键词

- 中文关键词：字段回传、回传前事件、性能优化、页面录入
- 英文关键词：`BeforeFieldPostBackEvent`
- 常见别名：字段回传拦截、字段回传事件
- 常见报错词：联动不触发、字段回传过多、页面卡顿
