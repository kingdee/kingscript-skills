# BeforeFilterF7SelectEvent

## 基本信息

- 名称：`BeforeFilterF7SelectEvent`
- Java 类名：`kd.bos.form.field.events.BeforeFilterF7SelectEvent`
- TS 导出名：`BeforeFilterF7SelectEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/field/events`
- 类型：过滤容器 F7 前置事件参数
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/field/events` 相关声明核对
  - 相关示例：[beforeFilterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeFilterF7Select.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于列表过滤栏、报表过滤栏或移动端过滤容器中的 F7 打开前控制过滤条件、已选值、自定义参数和打开表单信息。

## 典型场景

- 列表过滤容器按组织隔离可选资料
- 报表过滤栏按上游筛选条件联动 F7
- 控制过滤容器 F7 的多选、已选值和自定义参数

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getFieldName` | 获取映射字段名 | 无 | `String` | 区分当前过滤项 |
| `getQfilters` | 获取当前过滤条件 | 无 | `List<QFilter>` | 查看已有过滤 |
| `addCustomQFilter` | 追加自定义过滤 | `QFilter` | `void` | 保留原有过滤基础上补条件 |
| `setQfilters` | 整体替换过滤条件 | `List<QFilter>` | `void` | 需要完全重写条件时使用 |
| `getCustomParams` | 获取自定义参数 | 无 | `Map<String,Object>` | 过滤容器联动常用 |
| `setCancel` | 取消本次 F7 打开 | `boolean` | `void` | 条件不足时使用 |

## 运行时注意事项

- 过滤容器 F7 常见于列表、报表和移动端插件，不要误当成表单字段 F7。
- `getQfilters()` 返回的是当前已有条件，追加还是替换要明确。
- 多选、已选值和使用组织 ID 常会同时影响最终列表结果。

## 常见搭配

- 搭配类：`QFilter`、`ReportView`、`ListView`
- 搭配示例：[beforeFilterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeFilterF7Select.md)
- 搭配 FAQ：
  - 列表过滤栏 F7 怎么联动
  - 报表过滤项怎么按组织过滤

## 常见错误

### 1. 过滤条件被整包覆盖

高概率原因：
- 直接 `setQfilters()` 却没保留已有平台过滤
- 不清楚追加和替换的区别

### 2. 忽略已选值和多选状态

高概率原因：
- 只处理过滤条件，没有处理控件上下文

## 相关示例

- [beforeFilterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeFilterF7Select.md)

## 关键词

- 中文关键词：过滤容器 F7、列表过滤 F7、报表过滤 F7
- 英文关键词：`BeforeFilterF7SelectEvent`
- 常见别名：过滤栏 F7 事件、筛选 F7 前事件
- 常见报错词：过滤栏 F7 不生效、报表 F7 结果不对
