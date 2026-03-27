# createNewEntryRow - 新增默认分录行

## 适用场景

新建单据后自动补一条默认分录，或者用户点击按钮时按模板插入一行。

## 核心对象

- `createNewEntryRow(entryKey)`
- `setValue(fieldKey, value, rowIndex)`
- `updateView(entryKey)`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class SaleOrderDefaultEntryPlugin extends AbstractBillPlugIn {

  addDefaultEntry(): void {
    const entryKey = "billentry";
    const rows = this.getModel().getEntryEntity(entryKey);
    if (rows != null && rows.size() > 0) {
      return;
    }

    const rowIndex = this.getModel().createNewEntryRow(entryKey);
    this.getModel().setValue("material", 100001, rowIndex);
    this.getModel().setValue("qty", 1, rowIndex);
    this.getModel().setValue("taxprice", 0, rowIndex);
    this.getView().updateView(entryKey);
  }
}

let plugin = new SaleOrderDefaultEntryPlugin();
export { plugin };
```

## 注意事项

- `createNewEntryRow` 只负责插行，不会自动补全所有默认值。
- 补完值后如果界面没刷新，再调用 `updateView(entryKey)`。
- 行索引是模型层索引，不等于控件当前焦点行。
