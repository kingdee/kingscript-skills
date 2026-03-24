# CloseCallBack

## 基本信息

- 名称：`CloseCallBack`
- Java 类名：`kd.bos.form.CloseCallBack`
- TS 导出名：`CloseCallBack`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.form`
- 类型：页面关闭回调参数对象
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-form-metadata.d.ts`
  - Javadoc：待补充

## 用途概述

用于定义“子页面关闭后，父页面如何收到通知”。它通常作为 `FormShowParameter` 的一部分出现，而不是单独使用。

## 典型场景

- 父页面打开子页面后，需要在关闭时刷新数据
- 选择资料、选择列表、多选返回后回填到父页面
- 子页面完成处理后，把结果或动作标识回传给父页面

## 用户常见问法

- 子页面关闭后怎么回调父页面
- 回调 ID 应该怎么配
- 为什么页面关了但父页面没收到事件

## 常见搭配

- `FormShowParameter`
  - 通过 `setCloseCallBack(...)` 绑定回调
- `ClosedCallBackEvent`
  - 父页面真正接收到的关闭事件参数
- `AbstractFormPlugin`
  - 父页面里处理关闭回调的高频插件基类

## 高价值规则

- `CloseCallBack` 更像“回调约定”，不是业务数据本身
- 回调标识、父页面监听逻辑、子页面关闭动作三者要配套
- 如果是“打开页面后回写父页面”的需求，优先先想清楚回调链路

## 运行时注意事项

- 只有打开页面时正确带上回调配置，父页面关闭事件处理才有意义
- “页面关闭”不等于“回调一定已被正确接收”，还要看父页面处理逻辑

## 常见错误

### 1. 配了回调对象，但父页面没有反应

高概率原因：
- 回调标识不一致
- 父页面没有处理对应关闭事件
- 打开页面时没有把回调挂到 `FormShowParameter`

## 相关文档

- [FormShowParameter.md](FormShowParameter.md)
- [ClosedCallBackEvent.md](ClosedCallBackEvent.md)
- [AbstractFormPlugin.md](AbstractFormPlugin.md)

## 关键词

- 中文关键词：关闭回调、子页面回调、页面关闭通知
- 英文关键词：`CloseCallBack`
- 常见报错词：回调没触发、关闭后无反应
