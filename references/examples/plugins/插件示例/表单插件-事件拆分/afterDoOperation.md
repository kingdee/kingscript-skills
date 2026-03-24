# afterDoOperation - 操作后事件

来源：从 [表单插件.md](../表单插件.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 操作（如保存、提交、审核等）执行完成之后触发，可根据操作结果执行后续逻辑 |
| 方法签名 | `afterDoOperation(e: AfterDoOperationEventArgs): void` |

## 说明

在操作执行完成后触发的事件回调。通过该方法可以获取操作执行结果，根据操作是否成功来执行后续业务逻辑，如刷新界面、关闭页面、触发下游操作等。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | AfterDoOperationEventArgs | 事件参数对象 |
| e.getOperateKey() | string | 获取当前操作标识（如 save、submit、audit） |
| e.getOperationResult() | OperationResult | 获取操作执行结果对象 |
| e.getOperationResult().isSuccess() | boolean | 判断操作是否执行成功 |
| e.getOperationResult().getMessage() | string | 获取操作结果消息 |

## 业务场景

采购订单审核通过后，自动触发下推操作生成采购入库单，实现审核即入库的业务流程自动化。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { AfterDoOperationEventArgs } from "@cosmic/bos-core/kd/bos/form/events";
import { OperationServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper/operation";
import { ConvertServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { PushArgs } from "@cosmic/bos-core/kd/bos/entity/botp/runtime";

/**
 * 采购订单表单插件 - 审核通过后自动下推生成采购入库单
 */
class PmPurorderAutoPushPlugin extends AbstractBillPlugIn {

  afterDoOperation(e: AfterDoOperationEventArgs): void {
    super.afterDoOperation(e);

    const opKey = e.getOperateKey();

    if (opKey === "audit" &&
        e.getOperationResult() != null &&
        e.getOperationResult().isSuccess()) {
      const billId = this.getModel().getDataEntity().getPkValue();
      this.autoPushToInboundBill(billId);
    }

    if (opKey === "submit" &&
        e.getOperationResult() != null &&
        e.getOperationResult().isSuccess()) {
      this.getView().showSuccessNotification("单据提交成功，请等待审核");
    }
  }

  private autoPushToInboundBill(sourceBillId: any): void {
    try {
      const pushArgs = new PushArgs();
      pushArgs.setSourceFormId("pm_purorder");
      pushArgs.setTargetFormId("im_purinbill");

      const sourceIds: any[] = [sourceBillId];
      pushArgs.setBillIds(sourceIds);
      pushArgs.setConvertRuleKey("purorder_to_purinbill");

      const pushResult = ConvertServiceHelper.push(pushArgs);

      if (pushResult != null && pushResult.isSuccess()) {
        const targetBills = pushResult.getTargetDataEntities();

        if (targetBills != null && targetBills.length > 0) {
          const saveResult = OperationServiceHelper.executeOperate(
            "save",
            "im_purinbill",
            targetBills,
            null
          );

          if (saveResult.isSuccess()) {
            this.getView().showSuccessNotification("已自动生成采购入库单");
          } else {
            this.getView().showWarnNotification("采购入库单保存失败，请手动创建");
          }
        }
      } else {
        this.getView().showWarnNotification("下推生成采购入库单失败，请手动操作");
      }
    } catch (error: any) {
      this.getView().showErrorNotification("自动下推异常：" + error.message);
    }
  }
}

let plugin = new PmPurorderAutoPushPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.afterDoOperation(e)` 以确保父类逻辑正常执行
- 务必通过 `e.getOperationResult().isSuccess()` 判断操作是否成功，只有成功时才执行后续逻辑
- 下推操作可能因为转换规则、数据校验等原因失败，需做好异常处理
- 自动下推生成的目标单据需要手动调用保存操作才能持久化
- 此方法属于界面级事件，如果需要在无界面场景（如批量操作）中实现类似逻辑，应使用操作插件的 `afterExecuteOperationTransaction`
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
