# afterExecuteOperationTransaction - 根据执行结果收口

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractOperationServicePlugIn` |
| 触发时机 | 操作事务执行完成后 |
| 方法签名 | `afterExecuteOperationTransaction(e: AfterOperationArgs): void` |

## 说明

适合读取本次执行结果，补充提示、日志或为后续链路收集成功主键。

## 业务场景

批量保存后，根据成功主键数量写入一条统一的结果消息。

## 完整示例代码

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { AfterOperationArgs } from "@cosmic/bos-core/kd/bos/entity/plugin/args";

class SaveResultPlugin extends AbstractOperationServicePlugIn {

  afterExecuteOperationTransaction(e: AfterOperationArgs): void {
    super.afterExecuteOperationTransaction(e);

    const result = e.getOperationResult();
    if (result != null && result.isSuccess()) {
      const pkIds = result.getSuccessPkIds();
      result.setMessage("本次成功处理 " + pkIds.size() + " 条数据。");
    }
  }
}

let plugin = new SaveResultPlugin();
export { plugin };
```

## 注意事项

- 这里更适合读结果和补反馈，不适合再改本次待执行数据
- 想拿失败原因时，继续看 `OperationResult` 里的错误和校验集合
