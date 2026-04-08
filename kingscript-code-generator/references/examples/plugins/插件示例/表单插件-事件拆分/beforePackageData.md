# beforePackageData - 打印数据包扩展

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `IDataModelListener` |
| 触发时机 | 页面准备组织数据包输出前触发 |
| 方法签名 | `beforePackageData(e: BeforePackageDataEvent): void` |

## 说明

`beforePackageData` 适合在打印、预览、模板输出前补充扩展字段，把界面上的临时计算结果或额外上下文一起放入数据包。

## 业务场景

打印采购订单时，模板需要额外显示“审批说明”和“打印人”，而这两个字段并不直接存储在单据实体中。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { RequestContext } from "@cosmic/bos-core/kd/bos/context";
import { DynamicObject, DynamicObjectCollection } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import { BeforePackageDataEvent } from "@cosmic/bos-core/kd/bos/entity/datamodel/events";

class PurOrderPrintPackagePlugin extends AbstractBillPlugIn {

  beforePackageData(e: BeforePackageDataEvent): void {
    const dataPackage = e.getPageData() as DynamicObjectCollection;
    const currentUser = RequestContext.get().getUserName();
    const approveNote = this.getModel().getValue("approve_note");

    for (let i = 0; i < dataPackage.size(); i++) {
      const row = dataPackage.get(i) as DynamicObject;
      row.set("ext_print_user", currentUser);
      row.set("ext_approve_note", approveNote);
    }
    
  }
}

let plugin = new PurOrderPrintPackagePlugin();
export { plugin };
```

## 注意事项

- 先确认当前场景确实会走数据包输出链路。
- 这里只补充输出数据，不要改动单据主数据。
- 自定义扩展字段名建议统一前缀，避免和标准字段冲突。
