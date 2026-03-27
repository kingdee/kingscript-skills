# BeforeClosedEvent

## 基本信息

- 名称：`BeforeClosedEvent`
- Java 类名：`kd.bos.form.events.BeforeClosedEvent`
- TS 导出名：`BeforeClosedEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：页面关闭前事件参数
- 相关示例：[beforeClosed.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeClosed.md)

## 用途概述

用于在页面关闭前做最后一次确认、取消关闭、控制脏数据检查，以及决定是否跳过未绑定字段带来的提示。

## 典型场景

- 页面存在未保存修改时弹确认提示
- 某些只读或引导页面关闭时跳过脏数据检查
- 页面关闭前阻止用户离开，先补齐关键输入

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `setCancel(boolean)` | 取消关闭 | 直接拦截本次关闭 |
| `isCancel()` | 判断是否已取消 | 便于复用校验逻辑 |
| `setCheckDataChange(boolean)` | 控制是否检查数据变更 | 决定是否弹未保存提示 |
| `isCheckDataChange()` | 查看是否检查数据变更 | 用于排查关闭行为 |
| `setSkipNoField(boolean)` | 跳过未绑定物理字段的改动检查 | 适合纯展示或扩展字段场景 |
| `isSkipNoField()` | 查看是否跳过未绑定字段检查 | 用于排查误提示 |

## 运行时注意事项

- `beforeClosed` 负责关闭前判断，`pageRelease` 负责资源清理，职责不要混用。
- 关闭拦截和脏数据提示是两层概念，不要只改其中一层就期待整体行为都变。
- 跳过未绑定字段检查时，仍要确认真正绑定到模型的字段是否需要保留提示。

## 常见搭配

- 搭配事件：`beforeClosed`
- 搭配事件：`pageRelease`
- 搭配示例：[beforeClosed.md](../../examples/plugins/插件示例/表单插件-事件拆分/beforeClosed.md)
- 延伸示例：[pageRelease.md](../../examples/plugins/插件示例/表单插件-事件拆分/pageRelease.md)

## 常见错误

### 1. 误把资源释放写到 beforeClosed

高概率原因：
- 没区分“关闭前判断”和“页面释放”

### 2. 一直弹未保存提示

高概率原因：
- `setCheckDataChange` 与 `setSkipNoField` 配置不符合页面实际字段结构

## 关键词

- 中文关键词：关闭前校验、未保存提示、取消关闭、脏数据检查
- 英文关键词：`BeforeClosedEvent`
- 常见别名：beforeClosed 参数、关闭前事件参数
