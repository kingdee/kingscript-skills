# initListFilterAndTree - 列表初始化与过滤联动

## 场景

列表页面打开后，需要同时完成这三件事：初始化树列表显示层级、给过滤容器补一个业务单元筛选项、并在真正查询前把筛选项转换成列表过滤条件。

## Java 来源

- `kd.bos.plugin.sample.bill.list.bizcase.InitializeTreeSample`
- `kd.bos.plugin.sample.bill.list.bizcase.FilterContainerInitSample`

这两个 Java 样例一个偏树列表初始化，一个偏过滤容器和查询联动，合在一起更像真实业务里常见的“列表打开即带默认过滤”场景。

## 适用入口

- `initializeTree(e: $.java.util.EventObject): void`
- `filterContainerInit(args: FilterContainerInitArgs): void`
- `beforeF7Select(e: BeforeFilterF7SelectEvent): void`
- `setFilter(e: SetFilterEvent): void`
- 插件基类：`AbstractTreeListPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractTreeListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { FilterContainerInitArgs, SetFilterEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { BeforeFilterF7SelectEvent } from "@cosmic/bos-core/kd/bos/form/field/events";

class ListInitScenePlugin extends AbstractTreeListPlugin {
  currentOrgId: string;

  initializeTree(e: $.java.util.EventObject): void {
    super.initializeTree(e);

    this.getTreeModel().setRootVisable(true);
    this.getTreeModel().setTextFormat("名称{name}(编码{code})");
    this.getTreeModel().setDefaultQueryLevel(5);
    this.getTreeModel().getTreeFilter().add(new QFilter("number", "like", "%abc%"));
  }

  filterContainerInit(args: FilterContainerInitArgs): void {
    super.filterContainerInit(args);

    this.currentOrgId = String($.kd.bos.context.RequestContext.get().getOrgId());

    let columns = args.getFilterContainerInitEvent().getCommonFilterColumns();
    let orgColumn = new $.kd.bos.filter.CommonFilterColumn();
    orgColumn.setKey("orgfilter.id");
    orgColumn.setFieldName("orgfilter.id");
    orgColumn.setType("enum");
    orgColumn.setMustInput(true);
    orgColumn.setDefaultValue(this.currentOrgId);
    orgColumn.setCaption(new $.kd.bos.dataentity.entity.LocaleString("业务单元"));

    if (!columns.contains(orgColumn)) {
      columns.add(orgColumn);
    }
  }

  beforeF7Select(e: BeforeFilterF7SelectEvent): void {
    if (e.getFieldName() !== "orgfilter.id") {
      return;
    }

    e.setRefEntityId("bos_org");
    e.setRefPropKey("id");
  }

  setFilter(e: SetFilterEvent): void {
    super.setFilter(e);

    if (this.currentOrgId == null || this.currentOrgId === "") {
      return;
    }

    let filters = e.getQFilters();
    filters.add(new QFilter("org.id", "=", this.currentOrgId));
    e.setQFilters(filters);
  }
}

let plugin = new ListInitScenePlugin();
export { plugin };
```

## 映射说明

- `InitializeTreeSample` 里的核心动作是设置根节点可见、文本格式、默认查询层级和树过滤条件，这部分直接映射到 `initializeTree`。
- `FilterContainerInitSample` 里最有价值的是“打开列表时往过滤容器里补业务单元字段，并把默认组织带进去”，这里保留为 `filterContainerInit + setFilter` 的组合。
- Java 样例还处理了过滤容器里的 F7 引用信息，这里通过 `beforeF7Select` 单独说明，让“字段配置”和“真正查询过滤”职责分开。

## 注意事项

- `filterContainerInit` 更适合做过滤项初始化，真正影响查询结果的过滤条件仍建议收口到 `setFilter`。
- 树列表和普通列表都能做过滤联动，但只有树列表需要额外关注 `initializeTree` 里的层级和文本格式。
- 过滤容器字段的 key、fieldName 和最终查询字段不一定完全相同，写案例时要区分“界面字段”和“列表查询字段”。
- 这个场景案例偏列表打开即初始化；如果你只想查单个列表事件，应该回到列表插件事件拆分目录。
