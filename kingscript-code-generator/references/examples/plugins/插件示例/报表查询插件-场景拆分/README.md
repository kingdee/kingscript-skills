# 报表查询插件-场景拆分

这个目录聚焦“报表怎么取数、怎么按同一套过滤条件导出、怎么做左右联动查询”的高频问题，优先解决查询插件里最常见的整表导出、多 Sheet 导出、树形左侧驱动右侧明细和过滤复用场景。

## 案例列表

- [`queryAndExportByFilter.md`](./queryAndExportByFilter.md): 同一套过滤条件驱动页面查询、整表导出和按组织分 Sheet 导出
- [`treeLeftGroupQuery.md`](./treeLeftGroupQuery.md): 左侧树/分组节点取数，并按过滤条件动态增减左侧列
- [`treeRightListQuery.md`](./treeRightListQuery.md): 右侧明细表复用公共过滤并叠加当前选中左侧节点

## 使用建议

- 如果你已经确认自己写的是 `AbstractReportListDataPlugin`，优先看这里。
- 如果你要处理的是报表交互、列头排序过滤或合计行，而不是取数逻辑，回到 [`报表表单插件.md`](../报表表单插件.md) 或后续的场景拆分目录。
