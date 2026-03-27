# beginOperationTransaction - 事务开始后批量补值

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractOperationServicePlugIn` |
| 触发时机 | 服务端事务已经开始，可以安全处理待操作数据 |
| 方法签名 | `beginOperationTransaction(e: BeginOperationTransactionArgs): void` |

## 说明

适合在事务里对待处理数据做统一补值、状态调整或批量清洗。

## 业务场景

提交前统一给待处理单据补上自定义追踪标记，便于后续日志追溯。

## 完整示例代码

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { BeginOperationTransactionArgs } from "@cosmic/bos-core/kd/bos/entity/plugin/args";

class SubmitTracePlugin extends AbstractOperationServicePlugIn {

  beginOperationTransaction(e: BeginOperationTransactionArgs): void {
    super.beginOperationTransaction(e);

    const dataEntities = e.getDataEntities();
    for (let i = 0; i < dataEntities.length; i++) {
      dataEntities[i].set("cust_traceflag", "submit");
    }
  }
}

let plugin = new SubmitTracePlugin();
export { plugin };
```

## 注意事项

- 这里已经进入事务，适合处理本次待提交的数据
- 如果只是补字段加载，不要把逻辑放到这里
