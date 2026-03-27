# beforeQuickAddNew - 快速新增前校验

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 基础资料控件执行快速新增前触发 |
| 方法签名 | `beforeQuickAddNew(e: BeforeQuickAddNewEvent): void` |

## 说明

`beforeQuickAddNew` 用于拦截不满足前置条件的快速新增，或者在打开快速新增前给新页面传入默认值。

## 业务场景

录入供应商前必须先选择采购组织；如果组织为空，则禁止快速新增并提示用户先补齐组织。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeQuickAddNewEvent } from "@cosmic/bos-core/kd/bos/form/field/events";

class SupplierQuickAddGuardPlugin extends AbstractBillPlugIn {

  beforeQuickAddNew(e: BeforeQuickAddNewEvent): void {
    super.beforeQuickAddNew(e);

    if (e.getFieldKey() !== "supplier") {
      return;
    }

    const orgId = this.getModel().getValue("purchaseorg");
    if (orgId == null) {
      this.getView().showErrorNotification("请先选择采购组织，再进行供应商快速新增");
      e.setCancel(true);
      return;
    }

    e.getShowParameter().getCustomParams().put("default_org", orgId);
  }
}

let plugin = new SupplierQuickAddGuardPlugin();
export { plugin };
```

## 注意事项

- 阻止快速新增时要给明确提示，不要只取消不说明原因。
- 如果需要给快速新增页面传默认值，尽量通过参数而不是事后再改。
- 只对目标字段生效，避免影响其它基础资料控件。
