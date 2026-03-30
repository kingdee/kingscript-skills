# 报表表单插件-场景拆分

这个目录聚焦“报表页面交互怎么开”的问题，优先沉淀排序、列头过滤、合计行、导出合并列和二次处理阈值这些用户最常直接感知的表单侧能力。

## 案例列表

- [`enableSortFilterAndSummary.md`](./enableSortFilterAndSummary.md): 统一开启列头排序过滤，并为关键数值列补充合计行
- [`mergeColumnsAndLimitData.md`](./mergeColumnsAndLimitData.md): 导出时定义列合并规则，并限制二次过滤和二次排序的最大处理行数

## 使用建议

- 如果你的需求是“报表页面能不能排序、过滤、合计”，从这里开始。
- 如果你的需求开始涉及“导出长得对不对、前端二次排序过滤会不会太重”，也优先看这里。
- 如果你要写的是 DataSet 查询和导出逻辑，回到 [`报表查询插件-场景拆分/README.md`](../报表查询插件-场景拆分/README.md)。
