# beforeDoOperation - 操作前事件

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 操作（如保存、提交、审核等）执行之前触发，可在此进行界面级校验或二次确认 |
| 方法签名 | `beforeDoOperation(e: BeforeDoOperationEventArgs): void` |

## 说明

在用户触发操作（保存、提交、审核、删除等）但操作尚未真正执行之前触发的事件回调。通过该方法可以进行界面级别的业务校验，若校验不通过可调用 `e.setCancel(true)` 阻止操作继续执行。也可用于弹出二次确认对话框。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | BeforeDoOperationEventArgs | 事件参数对象 |
| e.getOperationKey() | string | 获取当前操作标识（如 save、submit、audit） |
| e.getSource() | FormOperate | 获取操作源对象，可进一步获取操作选项 |
| e.setCancel(boolean) | void | 设置为 true 可取消本次操作 |
| e.setCancelMessage(string) | void | 设置取消操作时的提示消息 |

## 业务场景

提交采购订单前，校验分录合计金额是否与单据头金额一致。如果不一致则阻止提交并提示用户修正，确保数据准确性。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeDoOperationEventArgs } from "@cosmic/bos-core/kd/bos/form/events";

/**
 * 采购订单表单插件 - 提交前校验分录合计金额与单据头金额一致
 */
class PmPurorderAmountCheckPlugin extends AbstractBillPlugIn {

  beforeDoOperation(e: BeforeDoOperationEventArgs): void {
    super.beforeDoOperation(e);

    const opKey = e.getOperationKey();

    if (opKey === "submit") {
      const rowCount = this.getModel().getEntryRowCount("billentry");
      if (rowCount === 0) {
        e.setCancel(true);
        this.getView().showWarnNotification("请至少添加一行分录后再提交");
        return;
      }

      let entryTotalAmount = BigDecimal.ZERO;
      for (let i = 0; i < rowCount; i++) {
        const amount = this.getModel().getValue("amount", i) as BigDecimal;
        if (amount != null) {
          entryTotalAmount = entryTotalAmount.add(amount);
        }
      }

      const headTotalAmount = this.getModel().getValue("totalamount") as BigDecimal;

      if (headTotalAmount == null) {
        e.setCancel(true);
        this.getView().showWarnNotification("单据头合计金额不能为空");
        return;
      }

      const diff = entryTotalAmount.subtract(headTotalAmount).abs();
      const tolerance = new BigDecimal("0.01");

      if (diff.compareTo(tolerance) > 0) {
        e.setCancel(true);
        this.getView().showWarnNotification(
          "分录合计金额（" + entryTotalAmount.toString() +
          "）与单据头金额（" + headTotalAmount.toString() +
          "）不一致，差额：" + diff.toString() + "，请检查后再提交"
        );
        return;
      }

      for (let i = 0; i < rowCount; i++) {
        const qty = this.getModel().getValue("qty", i) as BigDecimal;
        const price = this.getModel().getValue("price", i) as BigDecimal;
        const rowNum = i + 1;

        if (qty == null || qty.compareTo(BigDecimal.ZERO) <= 0) {
          e.setCancel(true);
          this.getView().showWarnNotification("第" + rowNum + "行数量必须大于0");
          return;
        }

        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
          e.setCancel(true);
          this.getView().showWarnNotification("第" + rowNum + "行单价不能为负数");
          return;
        }
      }
    }
  }
}

let plugin = new PmPurorderAmountCheckPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.beforeDoOperation(e)` 以确保父类逻辑正常执行
- 通过 `e.getOperationKey()` 判断当前操作类型，避免对所有操作都执行校验
- `e.setCancel(true)` 会阻止操作继续执行，用户界面不会有任何操作动作
- 此方法属于界面级校验，适合做数据完整性检查；更严格的业务规则校验应放在操作插件中
- 金额比较时建议使用 BigDecimal 的 `compareTo` 方法，不要直接用 `==` 比较
- 校验不通过时应给出明确的错误提示，帮助用户定位问题
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
