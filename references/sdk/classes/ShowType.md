# ShowType

## 基本信息

- 名称：`ShowType`
- Java 类名：`kd.bos.form.ShowType`
- TS 导出名：`ShowType`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.form`
- 类型：页面展示方式枚举类
- 来源：
  - TS 声明：`@cosmic/bos-core/bos-form-metadata.d.ts`
  - Javadoc：待补充

## 用途概述

用于指定页面打开后的展示方式，例如模态、非模态、新窗口、当前页面内打开等，是页面交互体验配置的关键对象。

## 典型场景

- 模态弹窗打开子页面
- 非模态打开辅助页面
- 在当前页面、当前表单或新标签中打开
- 为列表、单据、查询选择不同的呈现方式

## 用户常见问法

- 怎么模态打开页面
- 怎么在当前页面打开
- `Modal` 和 `NonModal` 有什么区别

## 常见搭配

- `FormShowParameter`
  - 负责承载页面打开参数
- `IFormView`
  - 负责真正执行打开动作
- `CloseCallBack`
  - 模态场景下常常需要一起设计回调

## 高频常量

- `ShowType.Default`
- `ShowType.InCurrentForm`
- `ShowType.Modal`
- `ShowType.NonModal`
- `ShowType.NewWindow`
- `ShowType.NewBrowserPage`
- `ShowType.MainNewTabPage`
- `ShowType.IFrame`

## 高价值规则

- 先想清楚用户交互关系，再选展示方式
- 需要父子页面强交互、强回调时，通常优先考虑模态类展示
- 只关心跳转、不关心回传时，可以考虑更轻的展示方式

## 运行时注意事项

- 同一个页面对象，换不同 `ShowType` 可能带来完全不同的交互体验
- 展示方式的选择会影响关闭回调、父子页面关系和用户操作路径

## 常见错误

### 1. 页面能打开，但交互体验不符合预期

高概率原因：
- 展示方式选错了
- 需要回调却用了不合适的展示模式

## 相关文档

- [FormShowParameter.md](FormShowParameter.md)
- [CloseCallBack.md](CloseCallBack.md)
- [IFormView.md](IFormView.md)

## 关键词

- 中文关键词：展示方式、模态、非模态、新窗口、当前页面打开
- 英文关键词：`ShowType`
- 常见报错词：打开方式不对、弹窗方式不对
