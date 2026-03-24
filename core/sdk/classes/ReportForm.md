# ReportForm

## 基本信息

- 名称：`ReportForm`
- Java 类名：`kd.bos.report.ReportForm`
- TS 导出名：`ReportForm`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.report`
- 类型：报表表单类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/report.d.ts`
  - 相关文档：[2.2.5.1报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/docs/plugin-development/2.2.5%E6%8A%A5%E8%A1%A8%E6%8F%92%E4%BB%B6/2.2.5.1%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
  - Javadoc：待补充

## 用途概述

用于承载报表表单层的能力，是理解报表页面和报表插件关系的重要对象。

## 典型场景

- 报表表单插件开发
- 报表查询参数初始化
- 报表界面展示与交互处理

## 高价值规则

- 报表表单类偏报表页面承载层
- 如果问题偏报表取数逻辑，应继续看报表数据插件相关基类
- 如果问题偏报表界面交互，则 `ReportForm` 和 `IReportView` 更关键

## 相关文档

- [IReportView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/IReportView.md)
- [ReportView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/ReportView.md)
- [4.3.2.5报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.5%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)

## 关键词

- 中文关键词：报表表单、报表页面
- 英文关键词：`ReportForm`
- 常见报错词：报表表单插件、报表页面对象
