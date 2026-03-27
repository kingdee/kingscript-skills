# AfterDoOperationEventArgs

## 基本信息

- 名称：`AfterDoOperationEventArgs`
- Java 类名：`kd.bos.form.events.AfterDoOperationEventArgs`
- TS 导出名：`AfterDoOperationEventArgs`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：表单操作后事件参数
- 相关示例：[afterDoOperation.md](../../examples/plugins/插件示例/表单插件-事件拆分/afterDoOperation.md)

## 用途概述

用于读取操作执行后的标识和结果，适合在保存、提交、审核完成后做页面刷新、结果提示、关闭回调或后续联动。

## 典型场景

- 保存成功后刷新局部视图
- 提交成功后弹提示并关闭页面
- 根据不同操作 key 分发不同后处理逻辑
- 读取 `OperationResult` 判断是否真正成功

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `getOperateKey()` | 获取操作标识 | 用于区分保存、提交、审核等 |
| `getOperationResult()` | 获取操作结果 | 判断是否成功、是否带返回信息 |
| `getObjectId()` | 获取对象标识 | 兼容旧链路时常见 |
| `getSource()` | 获取事件源 | 通常用于定位来源 |

## 运行时注意事项

- 这里只适合处理“操作完成后”的逻辑，不再做前置拦截。
- 操作 key 和对象标识不要混为一谈，尤其是兼容旧版本字段时。
- 如果要刷新页面，先确认当前操作是否真的成功。

## 常见搭配

- 搭配基类：`AbstractFormPlugin`
- 搭配事件：`afterDoOperation`
- 搭配示例：[afterDoOperation.md](../../examples/plugins/插件示例/表单插件-事件拆分/afterDoOperation.md)

## 常见错误

### 1. 不判断结果就直接提示成功

高概率原因：
- 只拿到了 `operateKey`，没有校验 `OperationResult`

### 2. 误把 `getObjectId()` 当成操作 key

高概率原因：
- 混用了旧版兼容字段和真实操作标识

## 关键词

- 中文关键词：操作后回调、保存后处理、提交后提示、操作结果
- 英文关键词：`AfterDoOperationEventArgs`
- 常见别名：操作后事件参数、afterDoOperation 参数
