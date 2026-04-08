# treeLeftGroupQuery - 左侧树/分组节点查询

## 场景

报表左侧是一棵树或一个分组列表，负责给右侧明细提供“当前选中了哪个节点”的上下文。  
这个插件只做两件事：

- 返回左侧节点数据
- 按过滤条件动态增减左侧展示列

## Java 来源

- `kd.bos.plugin.sample.report.queryplugin.LeftGroupQueryPlugin`
- `kd.bos.plugin.sample.report.queryplugin.ReportTreeQueryPlugin`

## 适用入口

- `query(queryParam: ReportQueryParam, selectedObj: object): DataSet`
- `getColumns(allColumns: $.java.util.List): $.java.util.List`
- 插件基类：`AbstractReportListDataPlugin`

## 完整 Kingscript 示例

```typescript
import { DataSet } from "@cosmic/bos-core/kd/bos/algo";
import { LocaleString } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import {
  AbstractReportColumn,
  AbstractReportListDataPlugin,
  ReportQueryParam
} from "@cosmic/bos-core/kd/bos/entity/report";
import { ReportColumnFactory } from "@cosmic/bos-core/kd/bos/metadata/entity/report";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class TreeLeftGroupQueryPlugin extends AbstractReportListDataPlugin {

  private algoKey = "TreeLeftGroupQueryPlugin";
  private entityName = "kdtest_reporttree_ds";
  private selectFields = "number,name as textfield,longnumber,parent as pid,isleaf,id as rowid";
  private top = 5000;

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    return QueryServiceHelper.queryDataSet(
      this.algoKey,
      this.entityName,
      this.selectFields,
      this.copyHeadFilters(queryParam),
      queryParam.getSortInfo(),
      this.top
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

let plugin = new TreeLeftGroupQueryPlugin();
export { plugin };
```

## 映射说明

- 左侧插件只负责“把树节点查出来”，不要在这里叠加右侧明细专属过滤。
- `pid`、`rowid` 这类字段是左右联动的关键字段，左侧数据集里要稳定带出来。
- 动态列控制可以保留在左侧插件里，因为它本质上属于左侧节点展示规则。

## 注意事项

- 左侧树节点必须有稳定主键，例如这里的 `rowid`，否则右侧插件拿不到可靠的选中节点。
- `queryDataSet` 在本地声明层确认是 6 参数签名，这里显式补了 `top`。
- KS 示例统一只导出一个固定插件实例，不在一篇文档里混放多个插件类供直接导出。
