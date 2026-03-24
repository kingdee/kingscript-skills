# IReportView

## 基本信息

- 名称：`IReportView`
- Java 类名：`kd.bos.report.IReportView`
- TS 导出名：`IReportView`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.report`
- 类型：报表视图接口
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/report.d.ts`
  - 相关文档：[2.2.5.1报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.5%E6%8A%A5%E8%A1%A8%E6%8F%92%E4%BB%B6/2.2.5.1%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
  - Javadoc：待补充

## 用途概述

用于表示报表页面视图接口，是理解报表页面交互能力的第一入口。

## 典型场景

- 报表页面交互扩展
- 报表查询条件初始化
- 报表界面状态控制

## 高价值规则

- 如果问题偏“报表页面怎么交互”，优先从 `IReportView` 理解
- 如果问题偏“报表数据怎么取”，则优先看报表数据插件基类，而不是只看视图接口

## 相关文档

- [ReportView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/ReportView.md)
- [ReportForm.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/ReportForm.md)
- [2.2.5.1报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.5%E6%8A%A5%E8%A1%A8%E6%8F%92%E4%BB%B6/2.2.5.1%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)

## 关键词

- 中文关键词：报表视图、报表页面视图
- 英文关键词：`IReportView`
- 常见报错词：报表页面交互、报表视图
