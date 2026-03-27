# dataSelect - 列表选择联动事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractListPlugin` |
| 触发时机 | 用户在列表中选择数据行后触发 |
| 方法签名 | `dataSelect(e: DataSelectEvent): void` |

## 说明

`dataSelect` 适合读取当前选中行、计算选择数量、驱动按钮可用态或把勾选结果传给后续处理逻辑。

## 业务场景

在发货通知列表中，只有当用户至少选中一行已审核数据时，“批量下推”按钮才允许点击。

## 完整示例代码

```typescript
import { AbstractListPlugIn } from "@cosmic/bos-core/kd/bos/list/plugin";
import { DataSelectEvent } from "@cosmic/bos-core/kd/bos/list/events";

class DeliverySelectPlugin extends AbstractListPlugIn {

  dataSelect(e: DataSelectEvent): void {
    super.dataSelect(e);

    const selectedRows = this.getView().getSelectedRows();
    const enablePush = selectedRows != null && selectedRows.length > 0;

    this.getView().setBarItemEnabled("tbpush", enablePush);
    this.getView().setBarItemEnabled("tbexport", enablePush);
  }
}

let plugin = new DeliverySelectPlugin();
export { plugin };
```

## 注意事项

- 只用选择数量控制按钮时，尽量不要在这里重复查询数据库。
- 如果要求“所选行都满足某状态”才能操作，要对选中集逐条校验。
- 列表支持多选和单选时，按钮逻辑要分别考虑。
