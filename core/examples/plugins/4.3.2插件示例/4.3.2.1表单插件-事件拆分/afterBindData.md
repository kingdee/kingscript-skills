# afterBindData - 绑定数据后操作

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 数据完全绑定到界面控件之后触发，此时界面已完成渲染，可安全操作控件状态 |
| 方法签名 | `afterBindData(e: any): void` |

## 说明

在数据加载并绑定到界面控件完成后触发的事件回调。适用于根据已加载的数据动态控制界面控件的可见性、可编辑性、样式等。此时数据模型中的值已全部就绪，可以安全读取字段值来决定界面行为。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | EventObject | 事件参数对象，包含事件源信息 |

## 业务场景

单据加载完成后，根据单据状态动态控制各字段的可编辑性和可见性。例如：暂存状态时所有字段可编辑；已提交状态时锁定关键字段但允许修改备注；已审核或已关闭状态时整单只读，并隐藏保存和提交按钮。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { IBillView, BillOperationStatus } from "@cosmic/bos-core/kd/bos/bill";

/**
 * 采购订单表单插件 - 根据单据状态控制字段可编辑性和可见性
 */
class PmPurorderStatusControlPlugin extends AbstractBillPlugIn {

  afterBindData(e: any): void {
    super.afterBindData(e);

    const billStatus = this.getModel().getValue("billstatus") as string;
    const view = this.getView();

    switch (billStatus) {
      case "A":
        view.setEnable(true, "supplier");
        view.setEnable(true, "billdate");
        view.setEnable(true, "currency");
        view.setEnable(true, "remark");
        view.setVisible(true, "bar_save");
        view.setVisible(true, "bar_submit");
        view.setVisible(false, "bar_audit");
        break;

      case "B":
        view.setEnable(false, "supplier");
        view.setEnable(false, "billdate");
        view.setEnable(false, "currency");
        view.setEnable(true, "remark");
        view.setVisible(false, "bar_save");
        view.setVisible(false, "bar_submit");
        view.setVisible(true, "bar_audit");
        break;

      case "C":
        const auditView = view as IBillView;
        auditView.setBillStatus(BillOperationStatus.VIEW);
        view.setVisible(false, "bar_save");
        view.setVisible(false, "bar_submit");
        view.setVisible(false, "bar_audit");
        break;

      case "D":
        const closedView = view as IBillView;
        closedView.setBillStatus(BillOperationStatus.VIEW);
        view.setVisible(false, "bar_save");
        view.setVisible(false, "bar_submit");
        view.setVisible(false, "bar_audit");
        break;
    }

    const sourceBillNo = this.getModel().getValue("sourcebillno") as string;
    if (sourceBillNo != null && sourceBillNo !== "") {
      view.setVisible(true, "panel_source");
    } else {
      view.setVisible(false, "panel_source");
    }

    const rowCount = this.getModel().getEntryRowCount("billentry");
    for (let i = 0; i < rowCount; i++) {
      const linkedQty = this.getModel().getValue("linkedqty", i) as BigDecimal;
      if (linkedQty != null && linkedQty.compareTo(BigDecimal.ZERO) > 0) {
        view.setEnable(false, i, "qty");
        view.setEnable(false, i, "material");
      }
    }
  }
}

let plugin = new PmPurorderStatusControlPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.afterBindData(e)` 以确保父类逻辑正常执行
- 此方法在数据绑定完成后触发，可安全读取字段值并控制界面状态
- 与 `beforeBindData` 不同，此方法执行时界面控件已完成渲染，适合做控件状态控制
- 新建单据和编辑单据都会触发此方法
- 使用 `setBillStatus(BillOperationStatus.VIEW)` 可将整个单据设为只读模式
- 分录行级别的字段锁定需使用 `setEnable(false, rowIndex, fieldKey)` 的三参数重载
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
