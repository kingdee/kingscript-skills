# listBeforeBindData - 列表绑定前初始化

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractListPlugin` |
| 触发时机 | 列表数据绑定前触发 |
| 方法签名 | `listBeforeBindData(e: ListBeforeBindDataEvent): void` |

## 说明

`listBeforeBindData` 适合在列表首次打开或刷新前统一设置默认过滤条件、排序规则和界面初始化参数。

## 业务场景

采购订单列表默认只显示当前组织下未关闭、最近 30 天的单据，避免列表首次打开数据量过大。

## 完整示例代码

```typescript
import { AbstractListPlugIn } from "@cosmic/bos-core/kd/bos/list/plugin";
import { ListBeforeBindDataEvent } from "@cosmic/bos-core/kd/bos/list/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class PurOrderListInitPlugin extends AbstractListPlugIn {

  listBeforeBindData(e: ListBeforeBindDataEvent): void {
    super.listBeforeBindData(e);

    const orgId = this.getView().getContext().getCurrentOrganizationId();
    e.addQFilter(new QFilter("org.id", "=", orgId));
    e.addQFilter(new QFilter("documentstatus", "!=", "C"));
  }
}

let plugin = new PurOrderListInitPlugin();
export { plugin };
```

## 注意事项

- 默认过滤应尽量稳定，避免和用户手工查询条件互相覆盖。
- 如果场景允许用户清空默认条件，要保证行为可解释。
- 列表初始化逻辑过重时会直接影响打开速度。
