# ClosedCallBackEvent

## 基本信息

- 名称：`ClosedCallBackEvent`
- Java 类名：`kd.bos.form.events.ClosedCallBackEvent`
- TS 导出名：`ClosedCallBackEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form`
- 命名空间：`kd.bos.form.events`
- 类型：子页面关闭回调事件参数
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-form-metadata.d.ts`
  - Javadoc：待补充

## 用途概述

用于承载子页面关闭后回传给父页面的事件信息，是父页面处理关闭回调时最直接接触到的参数对象。

## 典型场景

- 子页面关闭后刷新父页面
- 读取子页面返回的数据或返回标识
- 根据不同回调动作做不同处理

## 用户常见问法

- 父页面关闭回调里拿到的参数是什么
- 怎么区分不同子页面或不同回调动作
- 怎么根据关闭回调刷新数据

## 常见搭配

- `CloseCallBack`
  - 定义回调约定
- `FormShowParameter`
  - 打开页面时绑定回调
- `AbstractFormPlugin`
  - 在父页面插件里处理关闭事件

## 高价值规则

- 先确认回调链路存在，再处理事件内容
- 先按回调标识分流，再决定要不要刷新、回填或继续打开页面
- 如果父页面接到的事件不符合预期，优先回头检查 `CloseCallBack` 配置

## 运行时注意事项

- 关闭回调事件是否能收到，前提是页面打开时已经建立了回调关系
- 即使事件触发了，也要先判断是哪一个子页面、哪一种动作回来的

## 常见错误

### 1. 关闭事件触发了，但父页面逻辑跑偏

高概率原因：
- 没按回调标识做分流
- 误把不同页面的回调当成同一类事件处理

## 相关文档

- [CloseCallBack.md](CloseCallBack.md)
- [FormShowParameter.md](FormShowParameter.md)
- [AbstractFormPlugin.md](AbstractFormPlugin.md)

## 关键词

- 中文关键词：关闭回调事件、子页面关闭事件、回传事件
- 英文关键词：`ClosedCallBackEvent`
- 常见报错词：回调事件不生效、事件参数为空
