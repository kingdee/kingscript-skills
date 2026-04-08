# treeRightListQuery - 右侧明细联动查询

## 场景

报表右侧是一张明细表，需要同时读取：

- 页面公共过滤条件
- 左侧当前选中的树/分组节点

这个插件只负责“右侧怎么查”，不再承担左侧树的取数职责。

## Java 来源

- `kd.bos.plugin.sample.report.queryplugin.RightListQueryPlugin`

## 适用入口

- `query(queryParam: ReportQueryParam, selectedObj: object): DataSet`
- 插件基类：`AbstractReportListDataPlugin`

## 完整 Kingscript 示例

```typescript
import { DataSet } from "@cosmic/bos-core/kd/bos/algo";
import { DynamicObject } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import {
  AbstractReportListDataPlugin,
  ReportQueryParam
} from "@cosmic/bos-core/kd/bos/entity/report";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class TreeRightListQueryPlugin extends AbstractReportListDataPlugin {

  private algoKey = "TreeRightListQueryPlugin";
  private defaultEntityName = "kdtest_reporttree_ds";
  private selectFields = "number,name,longnumber,parent";
  private top = 5000;

  query(queryParam: ReportQueryParam, selectedObj: object): DataSet {
    let entityName = this.readSourceKey(queryParam);
    let filters = this.buildFilters(queryParam, selectedObj);

    return QueryServiceHelper.queryDataSet(
      this.algoKey,
      entityName,
      this.selectFields,
      filters,
      "number asc",
      this.top
    );
  }

  private readSourceKey(queryParam: ReportQueryParam): string {
    let items = queryParam.getFilter().getFilterItems();
    if (items == null) {
      return this.defaultEntityName;
    }

    for (let i = 0; i < items.size(); i++) {
      let item = items.get(i);
      if (item.getPropName() === "rightlist" && item.getValue() != null) {
        return String(item.getValue());
      }
    }
    return this.defaultEntityName;
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

let plugin = new TreeRightListQueryPlugin();
export { plugin };
```

## 映射说明

- `selectedObj` 就是左右联动时右侧插件最关键的输入，不要再从页面字段反查当前树节点。
- 页面上用于控制联动行为的字段，例如 `leftgroup`、`rightlist`、`checkboxfield`，需要从业务过滤里排除掉。
- 右侧插件只关心“选中哪个节点后查什么明细”，不要把左侧树列定义也揉进来。

## 注意事项

- 如果右侧明细表关联字段不是 `parent.id`，要按真实数据源改成对应字段，不要照抄。
- `queryDataSet` 在本地声明层确认是 6 参数签名，这里显式补了 `top`。
- KS 示例统一只导出一个固定插件实例，不在一篇文档里混放多个插件类供直接导出。
