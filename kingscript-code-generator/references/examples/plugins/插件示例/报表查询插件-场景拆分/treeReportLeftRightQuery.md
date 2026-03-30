# treeReportLeftRightQuery - 树形左侧驱动右侧明细查询

## 场景

报表左侧是一棵分组树，右侧是一张明细表。用户在左侧切换节点后，右侧既要带上页面过滤条件，又要自动叠加当前树节点作为附加过滤，从而实现“左树选什么，右边就查什么”的联动。

## Java 来源

- `kd.bos.plugin.sample.report.queryplugin.LeftGroupQueryPlugin`
- `kd.bos.plugin.sample.report.queryplugin.RightListQueryPlugin`
- `kd.bos.plugin.sample.report.queryplugin.ReportTreeQueryPlugin`

这组 Java 样例组合起来表达了一个完整模型：

- 左侧插件负责返回树或分组数据
- 右侧插件负责读取公共过滤条件和当前选中节点
- 树报表还能按页面条件动态增减列定义

## 适用入口

- `query(queryParam: ReportQueryParam, selectedObj: object): DataSet`
- `getColumns(allColumns: $.java.util.List): $.java.util.List`
- 插件基类：`AbstractReportListDataPlugin`

## 完整 Kingscript 示例

```typescript
import { DataSet } from "@cosmic/bos-core/kd/bos/algo";
import { LocaleString } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import { DynamicObject } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import {
  AbstractReportColumn,
  AbstractReportListDataPlugin,
  ReportQueryParam
} from "@cosmic/bos-core/kd/bos/entity/report";
import { ReportColumnFactory } from "@cosmic/bos-core/kd/bos/metadata/entity/report";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class TreeReportLeftQueryPlugin extends AbstractReportListDataPlugin {

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    return QueryServiceHelper.queryDataSet(
      this.getClass().getName(),
      "kdtest_reporttree_ds",
      "number,name as textfield,longnumber,parent as pid,isleaf,id as rowid",
      this.copyHeadFilters(queryParam),
      queryParam.getSortInfo()
    );
  }

  getColumns(allColumns: $.java.util.List): $.java.util.List {
    let numberColumn = ReportColumnFactory.createTextColumn(
      new LocaleString("编码"),
      "number"
    );
    numberColumn.setHyperlink(true);
    allColumns.add(numberColumn);

    let checkboxItem = this.getQueryParam().getFilter().getFilterItem("checkboxfield");
    if (checkboxItem != null && checkboxItem.getBoolean()) {
      let longNumberColumn = ReportColumnFactory.createTextColumn(
        new LocaleString("长编码"),
        "longnumber"
      );
      allColumns.add(2, longNumberColumn as AbstractReportColumn);
    }

    return allColumns;
  }

  private copyHeadFilters(queryParam: ReportQueryParam): QFilter[] {
    let filters: QFilter[] = [];
    let headFilters = queryParam.getFilter().getHeadFilters();

    if (headFilters == null) {
      return filters;
    }

    for (let i = 0; i < headFilters.size(); i++) {
      filters.push(headFilters.get(i) as QFilter);
    }
    return filters;
  }
}

class TreeReportRightQueryPlugin extends AbstractReportListDataPlugin {

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let sourceKey = this.readSourceKey(queryParam);
    let filters = this.buildFilters(queryParam, selectedObj);

    return QueryServiceHelper.queryDataSet(
      this.getClass().getName(),
      sourceKey,
      "number,name,longnumber,parent",
      filters,
      "number asc"
    );
  }

  private readSourceKey(queryParam: ReportQueryParam): string {
    let items = queryParam.getFilter().getFilterItems();
    if (items == null) {
      return "kdtest_reporttree_ds";
    }

    for (let i = 0; i < items.size(); i++) {
      let item = items.get(i);
      if (item.getPropName() === "rightlist" && item.getValue() != null) {
        return String(item.getValue());
      }
    }
    return "kdtest_reporttree_ds";
  }

  private buildFilters(queryParam: ReportQueryParam, selectedObj: object): QFilter[] {
    let filters: QFilter[] = [];
    let items = queryParam.getFilter().getFilterItems();

    if (items != null) {
      for (let i = 0; i < items.size(); i++) {
        let item = items.get(i);
        let propName = item.getPropName();
        let value = item.getValue();

        if (propName === "rightlist" || propName === "leftgroup" || propName === "checkboxfield") {
          continue;
        }
        if (value == null || value === "") {
          continue;
        }

        filters.push(new QFilter(propName, QCP.equals, value));
      }
    }

    if (selectedObj != null) {
      let selectedRow = selectedObj as DynamicObject;
      let rowId = selectedRow.getString("rowid");
      if (rowId != null && rowId !== "") {
        filters.push(new QFilter("parent.id", QCP.equals, rowId));
      }
    }

    return filters;
  }
}

export { TreeReportLeftQueryPlugin, TreeReportRightQueryPlugin };
```

## 映射说明

- `LeftGroupQueryPlugin` 和 `RightListQueryPlugin` 的核心边界是“左侧负责给节点，右侧负责读选中对象并追加过滤”，这篇案例保留了同样的左右分工。
- `ReportTreeQueryPlugin` 的核心是树字段别名和按过滤项增减列，这里保留了 `pid`、`rowid`、`longnumber` 这几个关键字段，以及按 `checkboxfield` 动态插列的写法。
- Java 里的右侧插件会从 `selectedObj` 里取当前节点并叠加过滤；这里同样把 `selectedObj` 视为右侧联动的第一输入，而不是重新从页面字段反查当前节点。

## 注意事项

- 左右联动报表里，左侧数据集一定要带一个稳定主键字段，例如这里的 `rowid`，否则右侧无法安全识别当前选中节点。
- 右侧构造过滤条件时要把 `leftgroup`、`rightlist` 这类“控制联动本身”的字段排除掉，不要误当成业务字段直接下发。
- 如果左侧是树而不是普通列表，右侧常见的过滤字段通常是 `parent.id`、分组 id 或路径字段，落库前要先和真实数据源字段名对齐。
