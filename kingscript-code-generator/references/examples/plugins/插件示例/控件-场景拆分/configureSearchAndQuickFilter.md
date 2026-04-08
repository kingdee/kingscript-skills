# configureSearchAndQuickFilter - 配置搜索联想与快速打开

## 场景

页面上有一个搜索框，用户希望输入关键词后同时搜到多类基础资料，先看到联想建议，再从建议项里直接打开目标单据，而不是只返回一串普通文本。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.control.bizcase.SearchSample`

这个 Java 样例的核心动作有 3 个：

- 在 `registerListener` 里给 `Search` 控件挂 `SearchEnterListener`
- 在 `getSearchList` 里根据输入词同时查询多类对象并返回建议列表
- 在 `search` 里复用前一步缓存的结果，直接打开用户选中的目标页面

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `getSearchList(evt: SearchEnterEvent): $.java.util.List`
- `search(evt: SearchEnterEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { BillShowParameter } from "@cosmic/bos-core/kd/bos/bill";
import { DynamicObject } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { SearchEnterEvent } from "@cosmic/bos-core/kd/bos/form/control/events";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { ArrayList } from "@cosmic/bos-script/java/util";

class ConfigureSearchAndQuickFilterPlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    let searchControl = this.getView().getControl("searchap") as any;
    searchControl.addSearchEnterListener(this);
  }

  getSearchList(evt: SearchEnterEvent): $.java.util.List {
    let keyword = evt.getText();
    let suggestions = new ArrayList();
    if (keyword == null || keyword.trim() === "") {
      return suggestions;
    }

    let searchMap: any = {};
    this.appendSearchResult(
      suggestions,
      searchMap,
      "结算方式",
      "bd_settlementtype",
      "bd_settlementtype",
      keyword
    );
    this.appendSearchResult(
      suggestions,
      searchMap,
      "币别",
      "bd_currency",
      "bd_currency",
      keyword
    );

    this.getView().getPageCache().put("searchList", JSON.stringify(searchMap));
    return suggestions;
  }

  search(evt: SearchEnterEvent): void {
    let selectedText = evt.getText();
    if (selectedText == null || selectedText.trim() === "") {
      return;
    }

    let cachedText = this.getView().getPageCache().get("searchList") as string;
    if (cachedText == null || cachedText === "") {
      this.getView().showTipNotification("请先输入关键词并从联想结果中选择。");
      return;
    }

    let searchMap = JSON.parse(cachedText);
    let hit = searchMap[selectedText];
    if (hit == null) {
      this.getView().showTipNotification("未命中搜索建议，请重新选择建议项。");
      return;
    }

    let showParam = new BillShowParameter();
    showParam.setFormId(hit.formId);
    showParam.setPkId(hit.pkId);
    this.getView().showForm(showParam);
  }

  private appendSearchResult(
    suggestions: $.java.util.List,
    searchMap: any,
    caption: string,
    businessObject: string,
    formId: string,
    keyword: string
  ): void {
    let filters = [
      new QFilter("number", "like", "%" + keyword + "%")
        .or(new QFilter("name", "like", "%" + keyword + "%"))
    ];

    let rows = QueryServiceHelper.query(
      businessObject,
      "id,number,name",
      filters,
      "number",
      10
    );

    for (let i = 0; i < rows.size(); i++) {
      let row = rows.get(i) as DynamicObject;
      let label = caption + "：" + row.getString("number") + " " + row.getString("name");
      suggestions.add(label);
      searchMap[label] = {
        formId: formId,
        pkId: row.getPkValue()
      };
    }
  }
}

let plugin = new ConfigureSearchAndQuickFilterPlugin();
export { plugin };
```

## 映射说明

- Java 样例里先查 `bd_settlementtype`、再查 `bd_currency`，这里保留了同样的“双来源联想”思路，只是用 `appendSearchResult` 把重复逻辑收敛起来。
- Java 里通过页面缓存保存建议列表和目标对象映射，这里同样使用 `getPageCache().put(...)`，保证 `getSearchList` 和 `search` 两个入口共享同一份结果。
- Java 最终用 `BillShowParameter` 打开命中的单据，这里也保留了“输入一次，选中即打开”的完整闭环，而不是只停留在提示词阶段。

## 注意事项

- `search` 拿到的是当前确认文本，所以联想项文案要稳定，否则缓存键和值对不上。
- 如果一个搜索框需要同时搜多类对象，建议像这里一样给展示文案加前缀，避免同编码同名称互相覆盖。
- 页面缓存更适合存“本页临时搜索结果”；如果结果需要跨页面复用，不要继续放在 `getPageCache()` 里。
