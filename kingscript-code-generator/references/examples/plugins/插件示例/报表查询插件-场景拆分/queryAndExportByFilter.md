# queryAndExportByFilter - 查询与导出共用过滤链路

## 场景

报表页面支持多条件查询后，用户希望直接导出当前结果；当导出方式切换成“分 Sheet 导出”时，又希望按已选组织拆成多个 Sheet，而不是重写一套导出过滤逻辑。

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
import { BasedataEntityType } from "@cosmic/bos-core/kd/bos/entity";
import {
  AbstractReportListDataPlugin,
  ReportQueryParam
} from "@cosmic/bos-core/kd/bos/entity/report";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { ArrayList } from "@cosmic/bos-script/java/util";

class QueryAndExportByFilterPlugin extends AbstractReportListDataPlugin {

  private algoKey = "QueryAndExportByFilterPlugin";
  private formId = "kdtest_report001";
  private top = 1000;
  private selectFields =
    "billno,kdtest_integerfield,kdtest_decimalfield,kdtest_textfield,"
    + "kdtest_datefield,kdtest_datetimefield,kdtest_amountfield,kdtest_orgfield";

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let filters = this.buildFilters(queryParam, true);
    return QueryServiceHelper.queryDataSet(
      this.algoKey,
      this.formId,
      this.selectFields,
      filters,
      "billno asc",
      this.top
    );
  }

  export(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let exportType = queryParam.getFilter().getValue("exporttype") as string;
    if (exportType !== "1") {
      return NULL;
    }

    let filters = this.buildFilters(queryParam, true);
    return QueryServiceHelper.queryDataSet(
      this.algoKey,
      this.formId,
      this.selectFields,
      filters,
      "billno asc",
      this.top
    );
  }

  exportWithSheet(queryParam: ReportQueryParam, selectedObj: object): $.java.util.List {
    let exportType = queryParam.getFilter().getValue("exporttype") as string;
    if (exportType !== "2") {
      return NULL;
    }

    let resultList = new ArrayList();
    let orgs = queryParam.getFilter().getValue("orgfield") as DynamicObjectCollection;
    if (orgs == null || orgs.size() === 0) {
      let exportResult = new Object();
      exportResult["sheetName"] = "全部组织";
      exportResult["dataSet"] = this.query(queryParam, selectedObj);
      resultList.add(exportResult);
      return resultList;
    }

    for (let i = 0; i < orgs.size(); i++) {
      let org = orgs.get(i) as DynamicObject;
      let filters = this.buildFilters(queryParam, false);
      filters.push(new QFilter("kdtest_orgfield.id", QCP.equals, org.getPkValue()));

      let sheetData = QueryServiceHelper.queryDataSet(
        this.algoKey,
        this.formId,
        this.selectFields,
        filters,
        "billno asc",
        this.top
      );

      let orgType = org.getDataEntityType() as BasedataEntityType;
      let nameProp = orgType.getNameProperty();
      let exportResult = new Object();
      exportResult["sheetName"] = org.getString(nameProp);
      exportResult["dataSet"] = sheetData;
      resultList.add(exportResult);
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
- 本地 `@cosmic/bos-core` 当前能确认的 `QueryServiceHelper.queryDataSet` 是 6 参数签名，所以这里显式补上了 `top`，避免误写成不存在的 5 参数调用。
- `algoKey` 直接用当前插件定义的固定字符串，不再写 `this.getClass().getName()` 这类 Java 风格调用。
- `exportWithSheet` 这里返回的是 `List<Object>`，每个元素放 `sheetName` 和 `dataSet`；接口注释里会提到 `ReportExportDataResult`，但它当前没有作为可直接 import 的 Kingscript SDK 类型开放。
- 组织名称字段来自基础资料实体，所以需要先把 `org.getDataEntityType()` 视为 `BasedataEntityType`，再调用 `getNameProperty()`。
- 在返回类型是 `DataSet` 或 `List` 的分支里，空返回统一写 `return NULL;`；本地编译环境里直接写 `return null;` 会触发类型不匹配。

## 注意事项

- `export` 和 `exportWithSheet` 不是一定都会触发，通常由页面上的导出方式决定，所以要先判断 `exporttype`。
- 如果过滤面板里组织字段是多选基础资料，整表导出适合用 `in`，分 Sheet 导出则应改成单个组织 `equals`，不要混用。
- 报表查询插件优先只做取数和导出，不要把列头排序过滤、合计行等交互逻辑也塞进来，那些能力应放到报表表单插件。
