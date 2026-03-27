# basedataByNumber - 按编码给基础资料赋值

## 适用场景

根据外部编码、模板编码或规则值给基础资料控件直接赋值。

## 核心对象

- `BasedataEdit`
- `setItemByNumber(...)`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";

class SetSupplierByNumberPlugin extends AbstractBillPlugIn {

  fillSupplierByNumber(): void {
    const supplierEdit = this.getView().getControl("supplier") as BasedataEdit;
    supplierEdit.setItemByNumber("SUP0001");
    this.getView().updateView("supplier");
  }
}

let plugin = new SetSupplierByNumberPlugin();
export { plugin };
```

## 注意事项

- 按编码赋值和按主键赋值不是一回事，排错时先确认你当前拿到的到底是什么。
- 如果赋值后界面不刷新，再调用 `updateView`。
