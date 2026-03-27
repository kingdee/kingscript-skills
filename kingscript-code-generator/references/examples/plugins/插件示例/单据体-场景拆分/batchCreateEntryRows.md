# batchCreateEntryRows - 批量补充分录

## 适用场景

按外部数据或模板一次性生成多条分录，减少逐条插行的样板代码。

## 核心对象

- `batchCreateNewEntryRow(entryKey, rowCount)`
- `setValue(fieldKey, value, rowIndex)`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class BatchEntryPlugin extends AbstractBillPlugIn {

  fillEntryRows(): void {
    const entryKey = "billentry";
    const newRows = this.getModel().batchCreateNewEntryRow(entryKey, 3);
    const materials = [100001, 100002, 100003];

    for (let i = 0; i < newRows.length; i++) {
      const rowIndex = newRows[i];
      this.getModel().setValue("material", materials[i], rowIndex);
      this.getModel().setValue("qty", i + 1, rowIndex);
    }

    this.getView().updateView(entryKey);
  }
}

let plugin = new BatchEntryPlugin();
export { plugin };
```

## 注意事项

- 批量插行更适合“先有模板数据再回写”的场景。
- 批量补值后如需继续联动价格、税率等字段，要考虑后续联动顺序。
