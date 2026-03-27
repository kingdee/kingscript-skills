# beforeExecuteOperationTransaction - 事务执行前最终拦截

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractOperationServicePlugIn` |
| 触发时机 | 即将真正执行操作事务前 |
| 方法签名 | `beforeExecuteOperationTransaction(e: BeforeOperationArgs): void` |

## 说明

这是服务端操作真正执行前的最后一道入口，适合做批量拦截、最终一致性校验和关键前置准备。

## 业务场景

审核单据前检查是否所有待处理单据都已经生成必填的业务编号，缺失则直接阻断。

## 完整示例代码

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { BeforeOperationArgs } from "@cosmic/bos-core/kd/bos/entity/plugin/args";
import { KDException } from "@cosmic/bos-core/kd/bos/exception";

class AuditCheckPlugin extends AbstractOperationServicePlugIn {

  beforeExecuteOperationTransaction(e: BeforeOperationArgs): void {
    super.beforeExecuteOperationTransaction(e);

    const dataEntities = e.getDataEntities();
    for (let i = 0; i < dataEntities.length; i++) {
      const billNo = dataEntities[i].get("billno");
      if (billNo == null || billNo === "") {
        throw new KDException("单据编号为空，不能继续执行审核。");
      }
    }
  }
}

let plugin = new AuditCheckPlugin();
export { plugin };
```

## 注意事项

- 这是服务端拦截，不是页面提示
- 一旦这里抛异常，调用方通常会直接收到失败结果
