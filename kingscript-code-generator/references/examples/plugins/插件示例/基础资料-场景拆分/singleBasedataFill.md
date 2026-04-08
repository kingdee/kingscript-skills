# singleBasedataFill - 基础资料过滤后自动回填

## 适用场景

打开 F7 前先按组织过滤，选择后再自动回填联系人、电话等附加字段。

## 核心对象

- `BeforeF7SelectEvent`
- `AfterF7SelectEvent`
- `QFilter`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeF7SelectEvent, AfterF7SelectEvent, BeforeF7SelectListener, AfterF7SelectListener } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { ArrayList } from "@cosmic/bos-script/java/util";
import { BasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";

class SupplierScenePlugin extends AbstractBillPlugIn implements BeforeF7SelectListener, AfterF7SelectListener{

    registerListener(e: $.java.util.EventObject): void {
        let edit = this.getControl("supplier") as BasedataEdit;
        edit.addBeforeF7SelectListener(this);
        edit.addAfterF7SelectListener(this);
    }

  beforeF7Select(e: BeforeF7SelectEvent): void {
    if (e.getProperty().getName() !== "supplier") {
      return;
    }

    const orgId = this.getModel().getValue("purchaseorg");
    let list = new ArrayList();
    list.add(new QFilter("useorg.id", "=", orgId));
    e.setCustomQFilters(list);
  }

  afterF7Select(e: AfterF7SelectEvent): void {
    let edit = e.getSource() as BasedataEdit;
    if (edit.getFieldKey() !== "supplier") {
      return;
    }

    const supplierId = this.getModel().getValue("supplier");
    if (supplierId == null) {
      return;
    }

    const supplier = QueryServiceHelper.queryOne(
      "bd_supplier",
      "contactperson,phone",
      [new QFilter("id", "=", supplierId)]
    );

    if (supplier != null) {
      this.getModel().setValue("contactperson", supplier.get("contactperson"));
      this.getModel().setValue("contactphone", supplier.get("phone"));
    }
  }
}

let plugin = new SupplierScenePlugin();
export { plugin };
```

## 注意事项

- 过滤和回填通常是成对出现的，别只看一个事件。
- 复杂过滤还可以回跳 [beforeF7Select.md](../基础资料控件-事件拆分/beforeF7Select.md)。
