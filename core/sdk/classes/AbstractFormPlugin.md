# AbstractFormPlugin

## 基本信息

- 名称：`AbstractFormPlugin`
- Java 类名：`kd.bos.form.plugin.AbstractFormPlugin`
- TS 导出名：`AbstractFormPlugin`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/form`
- 命名空间：`kd.bos.form.plugin`
- 类型：动态表单插件基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/form/plugin.d.ts`
  - 相关示例：[4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
  - 相关案例：[2.2.1.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6/2.2.1.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
  - Javadoc：待补充

## 用途概述

用于动态表单场景下的页面交互、生命周期控制、控件操作和展示逻辑扩展。

## 典型场景

- 动态表单页面初始化
- 控件显示、隐藏、启用、禁用
- 页面加载、绑定、释放时的处理
- 水印、定时器、控件获取等界面扩展

## 用户常见问法

- 表单插件应该继承哪个基类
- 动态表单和单据插件怎么区分
- 控件扩展应该走哪个基类
- 页面释放、定时刷新、水印控制写在哪

## 常见搭配

- `this.getView()`
  - 页面和控件交互的核心入口
- `this.getModel()`
  - 表单数据读取与写入
- 定时器、页面释放、水印等表单级事件

## 高价值规则

- 动态表单场景优先使用 `AbstractFormPlugin`
- 如果是单据页面，不要误把它当成 `AbstractBillPlugIn` 的替代品
- 页面级逻辑、控件级逻辑、数据级逻辑要分清边界
- 页面释放和定时器这类事件要特别注意资源清理

## 高频场景

- 页面绑定后初始化显示
- 定时刷新
- 获取或替换控件
- 页面释放时清理缓存
- 设置水印内容

## 运行时注意事项

- 这是通用动态表单插件基类，单据插件场景和它并不等价
- 某些页面级事件在控件已销毁或尚未绑定时调用，不能想当然访问页面元素
- 定时器、缓存、页面资源需要成对管理，避免泄漏

## 常见错误

### 1. 单据场景误用 `AbstractFormPlugin`

高概率原因：
- 模板默认基类未调整
- 把动态表单插件和单据插件混用了

### 2. 页面级逻辑和数据级逻辑混在一起

高概率原因：
- 没有区分页面生命周期和业务数据生命周期

## 相关文档

- [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
- [2.2.1.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6/2.2.1.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
- [4.4.5单据无法选择已有插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/common-issues/4.4%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98/4.4.5%E5%8D%95%E6%8D%AE%E6%97%A0%E6%B3%95%E9%80%89%E6%8B%A9%E5%B7%B2%E6%9C%89%E6%8F%92%E4%BB%B6.md)
- [3.1调试KingScript.md](/E:/kingscript%20skills/kingscript-skill/core/docs/debugging/3.1%E8%B0%83%E8%AF%95KingScript.md)

## 关键词

- 中文关键词：表单插件、动态表单、控件扩展、页面生命周期
- 英文关键词：`AbstractFormPlugin`
- 常见报错词：插件类型不匹配、页面事件异常、资源未清理
