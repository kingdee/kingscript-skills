# BeforeDoOperationEventArgs

## 基本信息

- 名称：`BeforeDoOperationEventArgs`
- Java 类名：`kd.bos.form.events.BeforeDoOperationEventArgs`
- TS 导出名：`BeforeDoOperationEventArgs`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：表单操作前事件参数
- 相关示例：[beforeDoOperation.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeDoOperation.md)

## 用途概述

在表单操作真正执行之前提供拦截入口，常用于保存、提交、审核等操作前的前置校验、批量选择结果读取和取消提示。

## 典型场景

- 保存前校验关键字段是否为空
- 提交前校验分录是否至少存在一行
- 按操作标识区分不同按钮对应的前置逻辑
- 从列表批量操作场景中读取选中行

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `setCancel(boolean)` | 取消当前操作 | 常和提示语一起使用 |
| `isCancel()` | 判断是否已取消 | 便于复用公共校验逻辑 |
| `setCancelMessage(string)` | 设置取消原因 | 让用户知道为什么被拦截 |
| `getCancelMessage()` | 获取取消原因 | 用于链路内复核 |
| `getListSelectedData()` | 获取列表选中行 | 适合批量操作前检查 |
| `getSource()` | 获取事件源 | 一般较少单独使用 |

## 运行时注意事项

- 这是“操作前”参数，不适合读取最终执行结果。
- `setCancel(true)` 之后，后续真正的操作执行链不会继续。
- 如果按操作 key 分流，先确认当前版本里操作 key 是挂在当前事件参数上，还是要从 `e.getSource()` / `FormOperate` 一侧读取。
- 不要把 `BeforeDoOperationEventArgs`、`AfterDoOperationEventArgs`、`FormOperate` 上的同名/近名方法混着用。

## 常见搭配

- 搭配基类：`AbstractFormPlugin`
- 搭配事件：`beforeDoOperation`
- 搭配示例：[beforeDoOperation.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeDoOperation.md)

## 常见错误

### 1. 在操作前事件里读取“执行结果”

高概率原因：
- 把 `BeforeDoOperationEventArgs` 和 `AfterDoOperationEventArgs` 混用

### 2. 取消操作但没有说明原因

高概率原因：
- 只调用了 `setCancel(true)`，没补充提示信息

## 关键词

- 中文关键词：操作前校验、保存前拦截、提交前校验、取消操作
- 英文关键词：`BeforeDoOperationEventArgs`
- 常见别名：操作前事件参数、beforeDoOperation 参数
