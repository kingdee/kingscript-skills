# billClosedCallBack - 列表打开单据后的关闭回调

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `IListViewBillCloseCallBack` |
| 触发时机 | 从列表打开单据页面并关闭后触发 |
| 方法签名 | `billClosedCallBack(e: BillClosedCallBackEvent): void` |

## 说明

`billClosedCallBack` 用于处理“从列表进去编辑单据，再返回列表”这条链路中的回调，适合在关闭后刷新列表、恢复焦点、提示用户结果。

## 业务场景

用户从销售订单列表打开一张单据编辑并保存，返回列表后自动刷新当前列表并保留原查询条件。

## 完整示例代码

```typescript
import { AbstractListPlugIn } from "@cosmic/bos-core/kd/bos/list/plugin";
import { BillClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/list/events";

class SalesOrderBillClosePlugin extends AbstractListPlugIn {

  billClosedCallBack(e: BillClosedCallBackEvent): void {
    super.billClosedCallBack(e);

    if (e.getBillOperationStatus() === "save") {
      this.getView().refresh();
      this.getView().showSuccessNotification("单据已保存，列表已刷新");
    }
  }
}

let plugin = new SalesOrderBillClosePlugin();
export { plugin };
```

## 注意事项

- 先根据回调状态判断是否需要刷新，不要无差别重载列表。
- 如果用户只是查看后关闭，通常不需要额外提示。
- 和列表查询条件联动时，要确认刷新不会把用户当前筛选重置掉。
