# onPreparePropertys - 补操作前需要加载的字段

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractOperationServicePlugIn` |
| 触发时机 | 服务端操作执行前，准备本次需要读取的字段 |
| 方法签名 | `onPreparePropertys(e: PreparePropertysEventArgs): void` |

## 说明

这个事件适合补“本次操作一定会用到，但默认不一定加载”的字段，避免后面进入事务后再补查。

## 业务场景

审核销售订单时，需要同时读取单据头的 `billno`、`saleorg` 和分录的 `material`、`qty`，供后续事务校验和日志记录使用。

## 完整示例代码

```typescript
import { AbstractOperationServicePlugIn, PreparePropertysEventArgs } from "@cosmic/bos-core/kd/bos/entity/plugin";

class SaleOrderAuditOpPlugin extends AbstractOperationServicePlugIn {

  onPreparePropertys(e: PreparePropertysEventArgs): void {
    super.onPreparePropertys(e);

    const fieldKeys = e.getFieldKeys();
    fieldKeys.add("billno");
    fieldKeys.add("saleorg");
    fieldKeys.add("material");
    fieldKeys.add("qty");
  }
}

let plugin = new SaleOrderAuditOpPlugin();
export { plugin };
```

## 注意事项

- 这里只负责补字段，不负责真正改数据
- 能在这里补齐字段，后面的事务代码通常会更稳
