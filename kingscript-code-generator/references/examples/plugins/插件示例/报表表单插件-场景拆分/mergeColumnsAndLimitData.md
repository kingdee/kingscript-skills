# mergeColumnsAndLimitData - 导出合并列并限制排序过滤数据量

## 场景

报表导出到 Excel 时，需要把几列按规则合并；同时页面上的二次排序和二次过滤又不能无限放大数据量，否则前端交互会越来越慢。最稳妥的做法是在表单插件里同时控制“导出规则”和“前端二次处理阈值”。

## Java 来源

- `kd.bos.plugin.sample.report.formplugin.ReportColumnMergePlugin`
- `kd.bos.plugin.sample.report.formplugin.RptMaxDataSizeFormPlugin`

这两个 Java 样例刚好覆盖一前一后两个关键点：

- 导出初始化时定义列合并规则
- 列创建完成后，根据查询参数给报表列表设置排序/过滤的最大处理行数

## 适用入口

- `exportInitialize(e: ReportExportInitializeEvent): void`
- `afterCreateColumn(e: CreateColumnEvent): void`
- 插件基类：`AbstractReportFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractReportFormPlugin } from "@cosmic/bos-core/kd/bos/report/plugin";
import {
  CreateColumnEvent,
  MergeColumnRule,
  ReportExportInitializeEvent
} from "@cosmic/bos-core/kd/bos/report/events";
import { ArrayList } from "@cosmic/bos-script/java/util";

class MergeColumnsAndLimitDataPlugin extends AbstractReportFormPlugin {

  exportInitialize(e: ReportExportInitializeEvent): void {
    let mergeRules = new ArrayList();
    let sourceFields = new ArrayList();
    sourceFields.add("kdtest_integerfield");

    let targetFields = new ArrayList();
    targetFields.add("kdtest_integerfield5");

    mergeRules.add(new MergeColumnRule(sourceFields, targetFields));
    e.setMergeColumnRules(mergeRules);
  }

  afterCreateColumn(e: CreateColumnEvent): void {
    let reportList = this.getView().getControl("reportlistap") as any;
    let queryParam = this.readQueryParam(reportList);
    let filterMax = this.readLimit(queryParam, "filter");
    let orderMax = this.readLimit(queryParam, "order");

    if (filterMax > 0) {
      reportList.setFilter2ndMaxRowCount(filterMax);
    }

    if (orderMax > 0) {
      reportList.setOrder2ndMaxRowCount(orderMax);
    }
  }

  private readQueryParam(reportList: any): any {
    let reportView = reportList.getView() as any;
    let reportCache = reportView.getReportCache();
    return reportCache.getReportQueryParam(this.getView().getPageId());
  }

  private readLimit(queryParam: any, itemKey: string): number {
    if (queryParam == null || queryParam.getFilter() == null) {
      return 0;
    }

    let filterInfo = queryParam.getFilter();
    let filterItem = filterInfo.getFilterItem(itemKey);
    if (filterItem != null && filterItem.getValue() != null) {
      return Number(filterItem.getValue());
    }

    let qFilters = filterInfo.getQFilters();
    if (qFilters == null || qFilters.size() < 2) {
      return 0;
    }

    if (itemKey === "filter") {
      return Number(qFilters.get(1).getValue());
    }
    if (itemKey === "order") {
      return Number(qFilters.get(0).getValue());
    }
    return 0;
  }
}

let plugin = new MergeColumnsAndLimitDataPlugin();
export { plugin };
```

## 映射说明

- `ReportColumnMergePlugin` 在导出初始化阶段只做一件事：构造 `MergeColumnRule` 列表并交给事件对象，这里保持了同样的入口和规则组织方式。
- `RptMaxDataSizeFormPlugin` 的关键不在列本身，而在“列创建完成后拿到当前查询参数，再反向设置报表列表的二次处理上限”，这里同样把阈值控制放在 `afterCreateColumn`。
- Java 里同时兼容了普通过滤项和 `QFilters` 两条读取路径，这里也保留了双路径读取，避免筛选面板和快捷过滤来源不一致时漏掉限制值。

## 注意事项

- 列合并规则只影响导出结果，不会改变页面上报表列的显示方式，所以不要把页面布局调整误放到 `exportInitialize`。
- `setFilter2ndMaxRowCount` 和 `setOrder2ndMaxRowCount` 只适合兜住前端二次处理成本，真正的海量数据限制仍然应该优先放在查询侧。
- 如果 `qFilters` 的顺序在你的业务里不是固定的，就不要像示例这样按索引取值，应该改成按字段名识别后再转换。
