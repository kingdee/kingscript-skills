# AbstractReportListModel

## 基本信息

- 名称：`AbstractReportListModel`
- Java 类名：`kd.bos.report.AbstractReportListModel`
- TS 导出名：`AbstractReportListModel`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos`
- 命名空间：`kd.bos.report`
- 类型：报表列表模型抽象基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/report.d.ts`
  - 相关示例：[4.3.2.5报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.5%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)
  - Javadoc：待补充

## 用途概述

用于承接报表列表模型的共性能力，是理解报表结果数据与展示结构如何组织的重要抽象层。

## 典型场景

- 理解报表列表的数据模型来源
- 区分报表视图、报表列表、报表列表模型的职责
- 排查报表结果展示和数据组织的边界问题

## 高价值规则

- 视图层、列表层、模型层在报表里同样要分清
- `AbstractReportListModel` 更偏数据组织与结果模型，不是直接的插件基类
- 报表开发时，取数、模型、展示、交互经常混在一起，这个类有助于把边界拆开

## 相关文档

- [ReportList.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/ReportList.md)
- [ReportView.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/ReportView.md)
- [4.3.2.5报表表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.5%E6%8A%A5%E8%A1%A8%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md)

## 关键词

- 中文关键词：报表列表模型、报表模型
- 英文关键词：`AbstractReportListModel`
- 常见报错词：报表数据模型、结果组织异常
