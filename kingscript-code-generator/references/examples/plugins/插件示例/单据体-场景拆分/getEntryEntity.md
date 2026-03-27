# getEntryEntity - 遍历分录实体

## 适用场景

遍历单据体，汇总数量、查找空行、按条件定位某一行。

## 核心对象

- `getEntryEntity(entryKey)`
- `DynamicObjectCollection`
- `DynamicObject`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class EntrySummaryPlugin extends AbstractBillPlugIn {

  summaryQty(): void {
    const rows = this.getModel().getEntryEntity("billentry");
    let totalQty = 0;

    for (let i = 0; i < rows.size(); i++) {
      const row = rows.get(i);
      const qty = row.get("qty");
      if (qty != null) {
        totalQty += qty;
      }
    }

    this.getView().showTipNotification(`当前分录数量合计: ${totalQty}`);
  }
}

let plugin = new EntrySummaryPlugin();
export { plugin };
```

## 注意事项

- `getEntryEntity(entryKey)` 返回的是分录集合，不是控件对象。
- 如果问题是“怎么高亮某行/跳到某列”，要回到 `EntryGrid`。
