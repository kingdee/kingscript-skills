# deleteEntryRow - 删除指定分录行

## 适用场景

按业务规则删除一条分录，或者先校验再删除当前行。

## 核心对象

- `deleteEntryRow(entryKey, rowIndex)`
- `getEntryEntity(entryKey)`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class DeleteEntryPlugin extends AbstractBillPlugIn {

  removeLastEntry(): void {
    const entryKey = "billentry";
    const rows = this.getModel().getEntryEntity(entryKey);
    if (rows == null || rows.size() === 0) {
      return;
    }

    const rowIndex = rows.size() - 1;
    const qty = rows.get(rowIndex).get("qty");
    if (qty != null && qty > 0) {
      this.getView().showTipNotification("已有数量的分录不允许直接删除");
      return;
    }

    this.getModel().deleteEntryRow(entryKey, rowIndex);
    this.getView().updateView(entryKey);
  }
}

let plugin = new DeleteEntryPlugin();
export { plugin };
```

## 注意事项

- 删除前优先用 `getEntryEntity` 再确认行索引。
- 真正不能删的场景不要只靠界面控制，后端操作插件也要校验。
