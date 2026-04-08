# afterF7Select - F7 选择后回填

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | F7 选择结果返回后触发 |
| 方法签名 | `afterF7Select(e: AfterF7SelectEvent): void` |

## 说明

`afterF7Select` 用来读取用户最终选择结果，并把附加信息回填到当前表单模型中。

## 业务场景

选择供应商后，自动带出联系人、联系电话和默认收货地址。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { AfterF7SelectEvent, AfterF7SelectListener } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { BasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";

class SupplierFillPlugin extends AbstractBillPlugIn implements AfterF7SelectListener{

    registerListener(e: $.java.util.EventObject): void {
        let edit = this.getControl("supplier") as BasedataEdit;
        edit.addAfterF7SelectListener(this);
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
      "contactperson,phone,address",
      [new QFilter("id", "=", supplierId)]
    );

    if (supplier != null) {
      this.getModel().setValue("contactperson", supplier.get("contactperson"));
      this.getModel().setValue("contactphone", supplier.get("phone"));
      this.getModel().setValue("receiveaddress", supplier.get("address"));
    }
  }
}

let plugin = new SupplierFillPlugin();
export { plugin };
```

## 注意事项

- 这里适合做回填，不适合再次弹出选择页面。
- 回填多个字段后，如果界面没有自动刷新，再调用 `updateView`。
- 如果字段支持多选，先确认返回结果结构。
