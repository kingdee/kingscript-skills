# AfterBindDataEvent

## 基本信息

- 名称：`AfterBindDataEvent`
- Java 类名：`kd.bos.form.events.AfterBindDataEvent`
- TS 导出名：`AfterBindDataEvent`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form/events`
- 类型：绑定数据后事件参数
- 相关示例：[afterBindData.md](../../examples/plugins/插件示例/表单插件-事件拆分/afterBindData.md)

## 用途概述

在页面完成数据绑定后触发，适合根据当前显示状态更新控件、补提示、启动定时器或做界面级增强。

## 典型场景

- 页面打开后按单据状态隐藏或禁用按钮
- 绑定完成后启动定时器轮询
- 根据模型结果刷新局部展示、提示条或水印

## 常用方法

| 方法 | 作用 | 说明 |
|------|------|------|
| `getSource()` | 获取事件源 | 多用于链路确认 |

## 运行时注意事项

- 这里只适合做“绑定完成后的页面行为”，不要把保存前校验塞进来。
- 如果会重复触发，初始化逻辑要注意幂等。
- 启动定时器、注册额外监听后，记得在页面释放时清理。

## 常见搭配

- 搭配事件：`afterBindData`
- 搭配类：`AbstractFormPlugin`
- 搭配示例：[afterBindData.md](../../examples/plugins/插件示例/表单插件-事件拆分/afterBindData.md)
- 延伸示例：[timerElapsed.md](../../examples/plugins/插件示例/表单插件-事件拆分/timerElapsed.md)

## 常见错误

### 1. 每次绑定后重复注册资源

高概率原因：
- 没考虑 `afterBindData` 可能多次进入

## 关键词

- 中文关键词：绑定后、页面绑定完成、初始化完成、界面增强
- 英文关键词：`AfterBindDataEvent`
- 常见别名：afterBindData 参数、绑定后事件参数
