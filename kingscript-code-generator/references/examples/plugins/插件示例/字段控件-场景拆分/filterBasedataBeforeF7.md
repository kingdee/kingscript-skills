# filterBasedataBeforeF7 - F7 打开前过滤基础资料

## 场景

基础资料字段打开 F7 选择框前，需要按当前单据上下文动态追加过滤条件；如果某个过滤条件是固定的，还希望在初始化阶段先给控件一个默认过滤。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.field.bizcase.BasedataFieldBeforeF7SelectSample`

这个 Java 样例同时演示了两种思路：在初始化阶段给 `BasedataEdit` 设固定过滤，以及在 `beforeF7Select` 里根据当前上下文重新拼过滤条件。

## 适用入口

- `initialize(): void`
- `registerListener(e: $.java.util.EventObject): void`
- `beforeF7Select(e: BeforeF7SelectEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { BeforeF7SelectEvent, BeforeF7SelectListener } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { BasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";
import { ArrayList } from "@cosmic/bos-script/java/util";

class BasedataFilterScenePlugin extends AbstractFormPlugin implements BeforeF7SelectListener{

  initialize(): void {
    super.initialize();

    let edit = this.getView().getControl("basedatafield1") as BasedataEdit;
    if (edit != null) {
      edit.setQFilter(new QFilter("forbidstatus", "=", "A"));
    }
  }

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    let edit = this.getView().getControl("basedatafield1") as BasedataEdit;
    if (edit != null) {
      edit.addBeforeF7SelectListener(this);
    }
  }

  beforeF7Select(e: BeforeF7SelectEvent): void {

    if (e.getProperty().getName() !== "basedatafield1") {
      return;
    }

    let useOrg = this.getModel().getValue("useorg") as any;
    let filters = new ArrayList();
    filters.add(new QFilter("forbidstatus", "=", "A"));

    if (useOrg != null) {
      filters.add(new QFilter("useorg.id", "=", useOrg.get("id")));
    }

    e.setCustomQFilters(filters);
  }
}

let plugin = new BasedataFilterScenePlugin();
export { plugin };
```

## 映射说明

- Java 样例在 `initialize` 里通过控件实例直接设固定过滤，在 Kingscript 里同样可以先 `getControl`，再对 `BasedataEdit` 调用 `setQFilter`。
- Java 样例在 `beforeF7Select` 里构造 `QFilter`，再塞进 F7 打开参数；在 Kingscript 侧更常见也更直接的写法是 `e.setCustomQFilters(filters)`。
- 这样拆分后，“固定过滤”和“动态过滤”各自职责更清楚，也更适合用户按场景直接复用。

## 注意事项

- 固定过滤适合写在 `initialize`；依赖当前单据值的过滤更适合写在 `beforeF7Select`。
- 先判断字段 key，再追加过滤，避免误伤同一页面里的其他 F7 控件。
- 过滤条件字段名必须与实际基础资料模型一致，不能把业务字段 key 直接当成查询字段名。
- 如果问题变成“过滤容器里的 F7 怎么联动”，就应该切到过滤容器相关案例，而不是继续复用这个表单字段案例。
