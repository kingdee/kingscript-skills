# BillClosedCallBackEvent

## 基本信息

- 名称：`BillClosedCallBackEvent`
- Java 类名：`kd.bos.list.events.BillClosedCallBackEvent`
- TS 导出名：`BillClosedCallBackEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/list/events`
- 类型：列表侧单据关闭回调事件
- 来源：
  - TS 声明：待按本地 `@cosmic/bos-core` 中 `kd/bos/list/events` 相关声明核对
  - 相关示例：[billClosedCallBack.md](../../examples/plugins/插件示例/列表插件-事件拆分/billClosedCallBack.md)
  - Javadoc：Cosmic V8.0.1

## 用途概述

用于列表插件打开单据后接收关闭通知，可依据回调标识和主键决定刷新列表、恢复选中状态或继续打开后续页面。

## 典型场景

- 列表新建单据关闭后自动刷新
- 根据回调标识区分不同打开来源
- 关闭子单据后把新建记录补回列表选中集

## 常用方法

| 方法 | 作用 | 关键参数 | 返回值 | 说明 |
|------|------|----------|--------|------|
| `getCloseCallBack` | 获取关闭回调对象 | 无 | `CloseCallBack` | 读取 `actionId`、类名等 |
| `getPkId` | 获取单据主键 | 无 | `Object` | 判断是否创建成功、定位记录 |
| `getSource` | 获取事件源 | 无 | `Object` | 辅助区分来源 |

## 运行时注意事项

- 只有打开子单据时显式设置 `CloseCallBack`，关闭回调才会回来。
- 列表刷新后如果需要恢复选中，要同步处理选中状态。
- `pkId` 为 `0`、空值或无效值时，通常表示未形成有效单据。

## 常见搭配

- 搭配类：`CloseCallBack`、`ListView`
- 搭配示例：[billClosedCallBack.md](../../examples/plugins/插件示例/列表插件-事件拆分/billClosedCallBack.md)
- 搭配 FAQ：
  - 列表打开单据关闭后怎么刷新
  - 怎么区分不同来源的关闭回调

## 常见错误

### 1. 没设置关闭回调就等回调触发

高概率原因：
- 只调用了 `showForm()`，没补 `setCloseCallBack()`

### 2. 只刷新不恢复选中状态

高概率原因：
- 没考虑列表体验
- 忽略了新建成功后列表选中同步

## 相关示例

- [billClosedCallBack.md](../../examples/plugins/插件示例/列表插件-事件拆分/billClosedCallBack.md)

## 关键词

- 中文关键词：列表关闭回调、单据关闭回调、列表刷新
- 英文关键词：`BillClosedCallBackEvent`
- 常见别名：列表回调事件、关闭单据回调
- 常见报错词：关闭后不刷新、回调不触发、列表选中丢失
