# ListView

## 基本信息

- 名称：`ListView`
- Java 类名：`kd.bos.mvc.list.ListView`
- TS 导出名：`ListView`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/mvc`
- 命名空间：`kd.bos.mvc.list`
- 类型：列表视图实现类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/mvc/list.d.ts`
  - 相关示例：[列表插件.md](../../examples/plugins/插件示例/列表插件.md)
  - Javadoc：待补充

## 用途概述

用于表示列表页面在 MVC 体系中的视图实现层，是理解列表页面行为的重要入口。

## 典型场景

- 列表页面交互逻辑分析
- 列表插件能力定位
- 区分列表控件与列表视图整体行为

## 用户常见问法

- 列表页面能力看哪个类
- 列表插件对应的视图是什么
- `BillList` 和 `ListView` 有什么区别

## 常见搭配

- `BillList`
- `AbstractListView`
- 列表插件

## 高价值规则

- `ListView` 偏页面整体视图
- `BillList` 偏具体列表控件
- 排查列表插件行为时，先判断问题属于控件层还是页面层

## 相关文档

- [BillList.md](BillList.md)
- [列表插件.md](../../examples/plugins/插件示例/列表插件.md)

## 关键词

- 中文关键词：列表视图、列表页面、列表 MVC
- 英文关键词：`ListView`
- 常见报错词：列表页面行为、列表视图实现
