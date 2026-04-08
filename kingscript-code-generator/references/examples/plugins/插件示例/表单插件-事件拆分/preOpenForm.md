# preOpenForm - 打开表单前处理

来源：从 [表单插件.md](../表单插件.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 表单打开前最早期触发，此时界面尚未加载 |
| 方法签名 | `preOpenForm(e: PreOpenFormEventArgs): void` |

## 说明

在表单打开之前的最早阶段触发，可用于修改表单标题、布局参数，或根据条件拦截表单的打开。此时界面控件尚未创建，不能操作控件，但可以修改 `FormShowParameter` 中的参数。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | PreOpenFormEventArgs | 表单打开前事件参数 |
| e.setCancel(boolean) | void | 设置为 true 可取消打开表单 |
| e.setCancelMessage(string) | void | 设置取消打开时的提示信息 |

## 业务场景

根据用户权限控制是否允许打开某些敏感单据。在大额付款单表单中，当付款金额超过一定阈值（如100万）时，只有拥有特殊权限的用户才能打开查看。普通用户尝试打开时，系统拦截并提示无权限。

## 完整示例代码

```typescript
import { AbstractBillPlugIn, BillShowParameter } from "@cosmic/bos-core/kd/bos/bill";
import { PreOpenFormEventArgs } from "@cosmic/bos-core/kd/bos/form/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { RequestContext } from "@cosmic/bos-core/kd/bos/context";

/**
 * 付款单表单插件 - 大额付款单打开权限控制
 */
class ApPaybillAccessPlugin extends AbstractBillPlugIn {

  preOpenForm(e: PreOpenFormEventArgs): void {
    super.preOpenForm(e);

    const currentUserId = RequestContext.get().getCurrUserId();
    const formShowParameter = this.getView().getFormShowParameter() as BillShowParameter;
    const pkId = formShowParameter.getPkId();

    if (pkId == null || pkId === "0" || pkId === "") {
      return;
    }

    const billInfo = QueryServiceHelper.queryOne(
      "ap_paybill",
      "totalamount,currency.name as currencyname",
      [new QFilter("id", "=", pkId)]
    );

    if (billInfo == null) {
      return;
    }

    const totalAmount = billInfo.get("totalamount") as BigDecimal;
    const amountThreshold = new BigDecimal("1000000");

    if (totalAmount == null || totalAmount.compareTo(amountThreshold) < 0) {
      return;
    }

    const hasPermission = QueryServiceHelper.queryOne(
      "sys_user_permission",
      "id",
      [
        new QFilter("user", "=", currentUserId),
        new QFilter("permissioncode", "=", "LARGE_PAYMENT_VIEW"),
        new QFilter("usestatus", "=", 1)
      ]
    );

    if (hasPermission == null) {
      const currencyName = (billInfo.get("currencyname") as string) || "人民币";

      e.setCancel(true);
      e.setCancelMessage(
        "该付款单金额为" + currencyName + " " + totalAmount.toString() +
        "，超过大额付款阈值（100万），您没有查看大额付款单的权限。请联系管理员授权。"
      );
    }

    const customParams = formShowParameter.getCustomParams();
    if (customParams != null) {
      customParams.put("isLargePayment", "true");
    }
  }

  afterBindData(e: $.java.util.EventObject): void {
    super.afterBindData(e);

    const formShowParameter = this.getView().getFormShowParameter();
    const customParams = formShowParameter.getCustomParams();

    if (customParams != null && customParams.get("isLargePayment") === "true") {
      this.getView().showTipNotification(
        "注意：当前为大额付款单，请仔细核对付款信息"
      );
    }
  }
}

let plugin = new ApPaybillAccessPlugin();
export { plugin };
```

## 注意事项

- `preOpenForm` 是表单打开前最早触发的事件，此时界面控件尚未创建
- 通过 `e.setCancel(true)` 可以拦截表单打开，`e.setCancelMessage()` 设置拦截提示信息
- 必须先调用 `super.preOpenForm(e)`
- 不能在此事件中操作界面控件（如 `this.getView().setVisible()`），因为控件尚未初始化
- 适用于权限校验、参数预处理、表单标题修改等场景
- 如果需要在界面加载后做进一步处理，应在 `afterBindData` 中实现
