# beforeF7Select - F7 选择前过滤

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | F7 基础资料选择框打开前触发 |
| 方法签名 | `beforeF7Select(e: BeforeF7SelectEvent): void` |

## 说明

`beforeF7Select` 适合基于当前单据上下文动态限制 F7 可选范围，比如按组织、业务类型、单据状态加过滤条件。

## 业务场景

采购订单录入物料时，只允许选择当前采购组织下启用且可采购的物料。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeF7SelectEvent } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class PurMaterialFilterPlugin extends AbstractBillPlugIn {

  beforeF7Select(e: BeforeF7SelectEvent): void {
    super.beforeF7Select(e);

    if (e.getProperty().getName() !== "material") {
      return;
    }

    const orgId = this.getModel().getValue("purchaseorg");
    const filters = [
      new QFilter("forbidstatus", "=", "A"),
      new QFilter("useorg.id", "=", orgId)
    ];

    e.setCustomQFilters(filters);
  }
}

let plugin = new PurMaterialFilterPlugin();
export { plugin };
```

## 注意事项

- 先判断字段，再加过滤，避免影响其它 F7 控件。
- 过滤条件要和实际基础资料模型字段一致。
- 复杂场景可和 `beforeFilterF7Select` 配合使用。
