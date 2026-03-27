# BeforeF7SelectEvent

## 基本信息

- 名称：`BeforeF7SelectEvent`
- Java 类名：`kd.bos.form.field.events.BeforeF7SelectEvent`
- TS 导出名：`BeforeF7SelectEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/field/events`
- 类型：F7 打开前事件参数
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/field/events` 相关声明核对
  - 相关示例：[beforeF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeF7Select.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于基础资料 F7 弹窗打开前追加过滤条件、调整显示参数或直接取消本次选择。

## 典型场景

- 按当前组织、供应商、项目过滤可选资料
- 修改 F7 打开参数，如单选/多选、表单参数或显示样式
- 对不满足前置条件的场景直接取消选择

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getProperty` | 获取字段属性对象 | 无 | `IDataEntityProperty` | 判断当前字段 |
| `getRow` | 获取当前行号 | 无 | `int` | 分录 F7 常用 |
| `getFormShowParameter` | 获取打开参数 | 无 | `FormShowParameter` | 可调显示方式与自定义参数 |
| `addCustomQFilter` | 追加过滤条件 | `QFilter` | `void` | 常见于组织和状态过滤 |
| `setCustomQFilters` | 批量设置过滤条件 | `List<QFilter>` | `void` | 统一替换过滤 |
| `setCancel` | 取消本次选择 | `boolean` | `void` | 前置条件不满足时使用 |

## 运行时注意事项

- 字段 F7 和过滤容器 F7 不是同一事件对象，不要混用。
- `sourceMethod` 可能来自点击、编码录入或客户端赋值，过滤策略要结合来源判断。
- 分录场景要结合当前行而不是默认处理表头。

## 常见搭配

- 搭配类：`QFilter`、`FormShowParameter`、`BasedataEdit`
- 搭配示例：[beforeF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeF7Select.md)
- 搭配 FAQ：
  - F7 打开前怎么按组织过滤
  - F7 怎么改成单选或模态打开

## 常见错误

### 1. 过滤条件只追加不去重

高概率原因：
- 每次打开都重复叠加 `QFilter`
- 没区分已有过滤和自定义过滤

### 2. 忽略来源方法

高概率原因：
- 把点击弹窗和编码回车当成同一流程处理

## 相关示例

- [beforeF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/beforeF7Select.md)

## 关键词

- 中文关键词：F7 前置过滤、基础资料过滤、资料选择前事件
- 英文关键词：`BeforeF7SelectEvent`
- 常见别名：F7 打开前事件、资料选择前事件
- 常见报错词：F7 过滤不生效、F7 还是能选错资料
