# BeforeBindDataEvent

## 基本信息

- 名称：`BeforeBindDataEvent`
- Java 类名：`kd.bos.form.events.BeforeBindDataEvent`
- TS 导出名：`BeforeBindDataEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：绑定数据前事件参数
- 相关示例：[beforeBindData.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeBindData.md)

## 用途概述

在页面把模型数据绑定到界面之前触发，适合做初始化准备、状态预判和界面控件的前置布置。

## 典型场景

- 按单据状态预先决定按钮是否可用
- 根据上下文初始化页面标记位
- 在界面真正渲染前准备默认值或只读控制

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `getSource()` | 获取事件源 | 常用于确认当前绑定链路来源 |

## 运行时注意事项

- 这是“绑定前”事件，适合做准备，不适合依赖界面已渲染的状态。
- 如果需要读取界面显示结果，通常应该放到 `AfterBindDataEvent`。
- 不要在这里塞入过重的查询逻辑，容易影响页面首次打开速度。

## 常见搭配

- 搭配事件：`beforeBindData`
- 搭配类：`AbstractFormPlugin`
- 搭配示例：[beforeBindData.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeBindData.md)

## 常见错误

### 1. 在绑定前直接依赖界面控件状态

高概率原因：
- 把“模型准备阶段”和“界面渲染后阶段”混在一起

## 关键词

- 中文关键词：绑定前、页面初始化、绑定前事件、界面准备
- 英文关键词：`BeforeBindDataEvent`
- 常见别名：beforeBindData 参数、绑定前事件参数
