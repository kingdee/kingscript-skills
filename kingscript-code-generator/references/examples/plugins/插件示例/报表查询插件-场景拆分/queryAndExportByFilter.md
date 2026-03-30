# queryAndExportByFilter - 查询与导出共用过滤链路

## 场景

报表页面支持多条件查询后，用户还希望直接导出当前结果；当导出方式切换为“分 Sheet 导出”时，又希望按已选组织拆成多个 Sheet，而不是重新写一套导出过滤逻辑。

## Java 来源

- `kd.bos.plugin.sample.report.queryplugin.TestReportExportPlugin`

这个 Java 样例的核心点有 3 个：

- `query` 和 `export` 复用同一套过滤收集逻辑
- `export` 通过 `exporttype = 1` 控制整表导出
- `exportWithSheet` 通过 `exporttype = 2` 和 `orgfield` 控制按组织拆 Sheet

## 适用入口

- `query(queryParam: ReportQueryParam, selectedObj: object): DataSet`
- `export(queryParam: ReportQueryParam, selectedObj: object): DataSet`
- `exportWithSheet(queryParam: ReportQueryParam, selectedObj: object): $.java.util.List`
- 插件基类：`AbstractReportListDataPlugin`

## 完整 Kingscript 示例

```typescript
import { DataSet } from "@cosmic/bos-core/kd/bos/algo";
import { DynamicObject, DynamicObjectCollection } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import {
  AbstractReportListDataPlugin,
  ReportExportDataResult,
  ReportQueryParam
} from "@cosmic/bos-core/kd/bos/entity/report";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { ArrayList } from "@cosmic/bos-script/java/util";

class QueryAndExportByFilterPlugin extends AbstractReportListDataPlugin {

  private formId = "kdtest_report001";
  private selectFields =
    "billno,kdtest_integerfield,kdtest_decimalfield,kdtest_textfield,"
    + "kdtest_datefield,kdtest_datetimefield,kdtest_amountfield,kdtest_orgfield";

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let filters = this.buildFilters(queryParam, true);
    return QueryServiceHelper.queryDataSet(
      this.getClass().getName(),
      this.formId,
      this.selectFields,
      filters,
      "billno asc"
    );
  }

  export(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let exportType = queryParam.getFilter().getValue("exporttype") as string;
    if (exportType !== "1") {
      return null;
    }

    let filters = this.buildFilters(queryParam, true);
    return QueryServiceHelper.queryDataSet(
      this.getClass().getName(),
      this.formId,
      this.selectFields,
      filters,
      "billno asc"
    );
  }

  exportWithSheet(queryParam: ReportQueryParam, selectedObj: object): $.java.util.List {
    let exportType = queryParam.getFilter().getValue("exporttype") as string;
    if (exportType !== "2") {
      return null;
    }

    let resultList = new ArrayList();
    let orgs = queryParam.getFilter().getValue("orgfield") as DynamicObjectCollection;
    if (orgs == null || orgs.size() === 0) {
      resultList.add(new ReportExportDataResult("全部组织", this.query(queryParam, selectedObj)));
      return resultList;
    }

    for (let i = 0; i < orgs.size(); i++) {
      let org = orgs.get(i) as DynamicObject;
      let filters = this.buildFilters(queryParam, false);
      filters.push(new QFilter("kdtest_orgfield.id", QCP.equals, org.getPkValue()));

      let sheetData = QueryServiceHelper.queryDataSet(
        this.getClass().getName(),
        this.formId,
        this.selectFields,
        filters,
        "billno asc"
      );

      let nameProp = org.getDataEntityType().getNameProperty();
      resultList.add(new ReportExportDataResult(org.getString(nameProp), sheetData));
    }

    return resultList;
  }

  private buildFilters(queryParam: ReportQueryParam, appendOrgIn: boolean): QFilter[] {
    let filters: QFilter[] = [];
    let headFilters = queryParam.getFilter().getHeadFilters();
    if (headFilters != null) {
      for (let i = 0; i < headFilters.size(); i++) {
        filters.push(headFilters.get(i) as QFilter);
      }
    }

    let qFilters = queryParam.getFilter().getQFilters();
    if (qFilters != null) {
      for (let i = 0; i < qFilters.size(); i++) {
        filters.push(qFilters.get(i) as QFilter);
      }
    }

    if (!appendOrgIn) {
      return filters;
    }

    let orgs = queryParam.getFilter().getValue("orgfield") as DynamicObjectCollection;
    if (orgs == null || orgs.size() === 0) {
      return filters;
    }

    let orgIds: object[] = [];
    for (let i = 0; i < orgs.size(); i++) {
      let org = orgs.get(i) as DynamicObject;
      orgIds.push(org.getPkValue());
    }

    if (orgIds.length > 0) {
      filters.push(new QFilter("kdtest_orgfield.id", QCP.in, orgIds));
    }
    return filters;
  }
}

let plugin = new QueryAndExportByFilterPlugin();
export { plugin };
```

## 映射说明

- Java 样例里私有的 `getQfilter(queryParam, boolean)` 被拆成了 `buildFilters(queryParam, appendOrgIn)`，这样更容易看清“公共过滤”和“按组织补 in 条件”的边界。
- `exporttype` 在 Java 里分别用 `"1"` 和 `"2"` 分流 `export`、`exportWithSheet`。这里沿用同一约定，避免页面查询和导出逻辑脱节。
- `exportWithSheet` 里每次循环都从公共过滤重新构造，再追加单个组织的 `equals` 条件，对应 Java 中“先复用过滤，再叠加当前 Sheet 组织”的写法。
- 这里用 `QueryServiceHelper.queryDataSet` 表达 DataSet 查询，和现有本地报表示例保持一致；场景重点在过滤链路复用，而不是 ORM/Helper 的具体实现差异。

## 注意事项

- `export` 和 `exportWithSheet` 不是一定都会触发，通常由页面上的导出方式决定，所以要先判断 `exporttype`。
- 如果过滤面板里组织字段是多选基础资料，整表导出适合用 `in`，分 Sheet 导出则应改成单个组织 `equals`，不要混用。
- 报表查询插件优先只做取数和导出，不要把列头排序过滤、合计行等交互逻辑也塞进来，那些能力应该放到报表表单插件。
