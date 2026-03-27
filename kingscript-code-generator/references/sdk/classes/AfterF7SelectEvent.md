# AfterF7SelectEvent

## 基本信息

- 名称：`AfterF7SelectEvent`
- Java 类名：`kd.bos.form.field.events.AfterF7SelectEvent`
- TS 导出名：`AfterF7SelectEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/field/events`
- 类型：F7 选择后事件参数
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/form/field/events` 相关声明核对
  - 相关示例：[afterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/afterF7Select.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于基础资料选择完成后读取选中结果、当前行、输入文本和回调标识，常见于多字段回填和选后联动。

## 典型场景

- 选择资料后回填描述、规格、组织等字段
- 根据多选结果批量追加分录
- 通过 `actionId` 区分不同来源的 F7 回调

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getListSelectedRow` | 获取第一条选中记录 | 无 | `ListSelectedRow` | 单选场景常用 |
| `getListSelectedRowCollection` | 获取所有选中记录 | 无 | `ListSelectedRowCollection` | 多选场景常用 |
| `getCurrentRowIndex` | 获取当前行号 | 无 | `int` | 分录回填定位 |
| `getInputValue` | 获取第一条输入值 | 无 | `Object` | 常配合编码录入场景 |
| `getInputTexts` | 获取输入文本集合 | 无 | `List<String>` | 用于区分编码与展示值 |
| `getActionId` | 获取回调标识 | 无 | `String` | 区分不同来源 |

## 运行时注意事项

- 不要默认只有单选返回；多选场景要走 `getListSelectedRowCollection()`。
- 回填逻辑通常需要结合当前行号和当前字段一起判断。
- 输入值和选中行不是同一语义，编码录入场景要特别注意。

## 常见搭配

- 搭配类：`ListSelectedRowCollection`、`IFormView`
- 搭配示例：[afterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/afterF7Select.md)
- 搭配 FAQ：
  - F7 选择后怎么带出多个字段
  - 多选怎么批量回填

## 常见错误

### 1. 只取第一条选中行

高概率原因：
- 直接使用 `getListSelectedRow()` 处理多选
- 忽略字段配置允许多选

### 2. 不区分输入值和选中结果

高概率原因：
- 把编码录入和弹窗选择混在一起处理

## 相关示例

- [afterF7Select.md](../../examples/plugins/插件示例/基础资料控件-事件拆分/afterF7Select.md)

## 关键词

- 中文关键词：F7 选择后、资料回填、选后联动、多选回填
- 英文关键词：`AfterF7SelectEvent`
- 常见别名：F7 回填事件、资料选择后事件
- 常见报错词：回填不完整、多选只带一条、当前行错乱
