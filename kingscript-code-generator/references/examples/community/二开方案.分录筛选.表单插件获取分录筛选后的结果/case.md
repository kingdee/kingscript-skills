# 二开方案.分录筛选.表单插件获取分录筛选后的结果

        ## 适用场景

        服务端表单插件需要拿到“分录小漏斗筛选后的结果”，再基于筛选结果做批量勾选、状态修改或批量计算。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/708375463240162816?specialId=570177930110532864>

        ## 核心思路

        1. 这类场景依赖单据体跨页模式，大分录才能把筛选事件抛到服务端插件。
2. 通过 `EntryGrid.addFilterEntryListener(...)` 监听筛选事件，在 `beforeFilterEntry(...)` 中读取筛选条件。
3. 拿到筛选条件后，再对当前分录集合做匹配，得到筛选后的行集合。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 单据体示例标识：`luk8_entryentity`
- 已在业务对象参数中启用单据体跨页模式
- 分录勾选字段示例：`luk8_checked`

        ## Kingscript 实现

        ```ts
        import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { EntryFilterItemInfo } from "@cosmic/bos-core/kd/bos/entity/property/entryfilter";
import { EntryGrid } from "@cosmic/bos-core/kd/bos/form/control";
import { EntryGridFilterEntryEvent } from "@cosmic/bos-core/kd/bos/form/control/events";
import { ItemClickEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { DynamicObjectCollection, DynamicObject } from "@cosmic/bos-core/kd/bos/dataentity/entity";

class EntryFilterResultPlugin extends AbstractFormPlugin {

  private matchedRows: number[] = [];

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);
    const entryGrid = this.getView().getControl("luk8_entryentity") as EntryGrid;
    if (entryGrid != null) {
      entryGrid.addFilterEntryListener(this);
    }
  }

  beforeFilterEntry(e: EntryGridFilterEntryEvent): void {
    const filterItems = e.getQueryParam().getFilterItems();
    this.matchedRows = [];
    if (filterItems == null || filterItems.size() === 0) {
      return;
    }

    const filterItem = filterItems.get(0) as EntryFilterItemInfo;
    const propName = filterItem.getPropName();
    const compareType = filterItem.getCompareType();
    const expectValue = String(filterItem.getValue());

    const rows = this.getModel().getEntryEntity("luk8_entryentity") as DynamicObjectCollection;
    for (let row = 0; row < rows.size(); row++) {
      const data = rows.get(row) as DynamicObject;
      const currentValue = String(data.get(propName));
      if (compareType === "=" && currentValue === expectValue) {
        this.matchedRows.push(row);
      }
    }
  }

  itemClick(e: ItemClickEvent): void {
    super.itemClick(e);
    if (e.getItemKey() !== "btn_mark_filtered") {
      return;
    }

    for (let i = 0; i < this.matchedRows.length; i++) {
      this.getModel().setValue("luk8_checked", true, this.matchedRows[i]);
    }
    this.getView().updateView("luk8_entryentity");
  }
}

let plugin = new EntryFilterResultPlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 先在业务对象参数中打开单据体跨页模式，这是服务端监听分录筛选事件的前提。
2. 给 `EntryGrid` 注册筛选监听，在事件里解析筛选条件。
3. 把解析出来的结果缓存在插件里，再由按钮或后续操作统一处理这些分录。

        ## 转写说明

        这篇原文其实给了较完整的 Java 思路，且缓存 HTML 中能直接定位到 `EntryGridFilterEntryEvent`、`EntryFilterItemInfo` 等关键类。这里按同一逻辑整理成 KS 版。

        ## 注意事项 / 风险点

        - 案例里只演示了单个筛选条件和等于比较；多条件、范围比较、包含比较要继续扩展解析逻辑。
- 跨页模式会改变单据体的一些行为，启用前要先评估业务影响。
- 如果筛选结果很多，建议不要逐行即时操作，最好交给按钮或批量操作统一执行。

        风险等级：`需按实际元数据调整`

        ## 验证建议

        1. 打开单据体小漏斗做单条件筛选，确认插件能记录匹配行。
2. 点击按钮后只勾选筛选结果行，未筛中的行保持不变。
3. 清空筛选后再次执行，确认不会残留旧的缓存结果。

        ## 来源说明

        - L3 Java 逻辑转 KS
- L4 本地资料校对

        - 本地 SDK 已确认 `EntryGridFilterEntryEvent`、`EntryFilterItemInfo`、`addFilterEntryListener(...)` 与 `beforeFilterEntry(...)` 都存在。
