# enableSortFilterAndSummary - 开启排序过滤并补合计行

## 场景

业务报表已经有数据了，但用户还需要在前端直接按列排序、列头过滤，并且希望金额、数量、均价等关键列在底部显示合计或平均值，而不是每个报表都单独点配置。

## Java 来源

- `kd.bos.plugin.sample.report.formplugin.ReportFilterPlugin`

补充参考：

- 现有 `报表表单插件.md` 中的 `setFloatBottomData` 用法

## 适用入口

- `setSortAndFilter(allColumns: $.java.util.List): void`
- `setFloatBottomData(summaryEvents: $.java.util.List): void`
- 插件基类：`AbstractReportFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractReportFormPlugin } from "@cosmic/bos-core/kd/bos/report/plugin";
import { SortAndFilterEvent } from "@cosmic/bos-core/kd/bos/report/events";

class EnableSortFilterAndSummaryPlugin extends AbstractReportFormPlugin {

  setSortAndFilter(allColumns: $.java.util.List): void {
    super.setSortAndFilter(allColumns);

    for (let i = 0; i < allColumns.size(); i++) {
      let event = allColumns.get(i) as SortAndFilterEvent;
      event.setFilter(true);
      event.setSort(true);
    }
  }

  setFloatBottomData(summaryEvents: $.java.util.List): void {
    super.setFloatBottomData(summaryEvents);

    for (let i = 0; i < summaryEvents.size(); i++) {
      let event = summaryEvents.get(i);
      let fieldKey = event.getFieldKey();

      if (fieldKey === "kdec_total_amount") {
        event.setSummaryType("sum");
        event.setCaption("金额合计");
      } else if (fieldKey === "kdec_total_qty") {
        event.setSummaryType("sum");
        event.setCaption("数量合计");
      } else if (fieldKey === "kdec_avg_price") {
        event.setSummaryType("avg");
        event.setCaption("平均单价");
      } else if (fieldKey === "billno") {
        event.setSummaryType("count");
        event.setCaption("记录数");
      }
    }
  }
}

let plugin = new EnableSortFilterAndSummaryPlugin();
export { plugin };
```

## 映射说明

- Java 的 `ReportFilterPlugin` 非常聚焦，只做一件事：遍历 `SortAndFilterEvent`，统一把 `setFilter(true)` 和 `setSort(true)` 打开。这里保留了这个核心动作。
- 为了把场景写完整，这里补上了 `setFloatBottomData`，让“能排、能筛、底部能看合计”成为一篇可直接复用的完整案例，而不是只剩一个事件片段。
- 这种组合更适合高频业务报表：查询插件负责取数，表单插件负责让结果更好用，两边职责清晰。

## 注意事项

- `setSortAndFilter` 只影响列头交互，不负责改查询 SQL 或 DataSet 排序逻辑。
- 合计行里常见的 `sum`、`avg`、`count` 都是表单侧展示能力；如果某列本身没有可计算值，强行设置合计没有意义。
- 当某些列不应该允许排序或过滤时，不要无差别全开，可以按字段标识做白名单或黑名单控制。
