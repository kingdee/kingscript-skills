# closedCallBack - 子页面关闭回调事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | ICloseCallBack |
| 触发时机 | 子页面（弹窗、F7选择界面等）关闭后回调到父页面时触发 |
| 方法签名 | `closedCallBack(e: ClosedCallBackEvent): void` |

## 说明

当从当前表单打开的子页面（如F7基础资料选择界面、自定义弹窗等）关闭后，系统会回调此方法，将子页面选择或操作的结果传回父页面。通过 `e.getActionId()` 区分不同的子页面回调，通过 `e.getReturnData()` 获取返回数据。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | ClosedCallBackEvent | 关闭回调事件参数 |
| e.getActionId() | string | 回调标识ID，用于区分不同的子页面来源 |
| e.getReturnData() | any | 子页面返回的数据 |

## 业务场景

从F7选择界面返回后，根据选择的供应商自动填充联系人、地址等信息。在采购订单中，用户点击供应商字段旁的自定义按钮打开供应商选择界面，选择供应商后关闭界面，系统自动将供应商的默认联系人、联系电话、收货地址等信息回填到采购订单对应字段中。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { FormShowParameter } from "@cosmic/bos-core/kd/bos/form";
import { ShowType } from "@cosmic/bos-core/kd/bos/form";
import { CloseCallBack } from "@cosmic/bos-core/kd/bos/form";
import { ClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/form/events";

/**
 * 采购订单表单插件 - 供应商选择后自动填充联系信息
 */
class PmPurorderSupplierFillPlugin extends AbstractBillPlugIn {

  registerListener(e: any): void {
    super.registerListener(e);

    // 注册自定义按钮点击监听
    this.addItemClickService("btn_select_supplier");
  }

  itemClick(e: any): void {
    super.itemClick(e);

    const itemKey = e.getItemKey();

    if (itemKey === "btn_select_supplier") {
      // 打开供应商选择界面
      const showParameter = new FormShowParameter();
      showParameter.setFormId("bd_supplier");
      showParameter.getOpenStyle().setShowType(ShowType.Modal);

      // 设置回调标识
      showParameter.setCloseCallBack(
        new CloseCallBack(this, "select_supplier")
      );

      this.getView().showForm(showParameter);
    }
  }

  closedCallBack(e: ClosedCallBackEvent): void {
    super.closedCallBack(e);

    const actionId = e.getActionId();

    if (actionId === "select_supplier") {
      const returnData = e.getReturnData();

      if (returnData == null) {
        return;
      }

      // 获取选中的供应商ID
      const supplierId = returnData.getPkValue();

      if (supplierId == null) {
        return;
      }

      // 回填供应商
      this.getModel().setValue("supplier", supplierId);

      // 查询供应商的详细信息
      const supplierInfo = QueryServiceHelper.queryOne(
        "bd_supplier",
        "name,contactperson,phone,address,bankname,bankaccount",
        [new QFilter("id", "=", supplierId)]
      );

      if (supplierInfo != null) {
        // 填充默认联系人
        const contactPerson = supplierInfo.get("contactperson") as string;
        if (contactPerson != null) {
          this.getModel().setValue("contactperson", contactPerson);
        }

        // 填充联系电话
        const phone = supplierInfo.get("phone") as string;
        if (phone != null) {
          this.getModel().setValue("contactphone", phone);
        }

        // 填充收货地址
        const address = supplierInfo.get("address") as string;
        if (address != null) {
          this.getModel().setValue("receiveaddress", address);
        }

        // 填充开户银行
        const bankName = supplierInfo.get("bankname") as string;
        if (bankName != null) {
          this.getModel().setValue("bankname", bankName);
        }

        // 填充银行账号
        const bankAccount = supplierInfo.get("bankaccount") as string;
        if (bankAccount != null) {
          this.getModel().setValue("bankaccount", bankAccount);
        }

        this.getView().showSuccessNotification(
          "已自动填充供应商【" + supplierInfo.get("name") + "】的联系信息"
        );
      }
    }
  }
}

let plugin = new PmPurorderSupplierFillPlugin();
export { plugin };
```

## 注意事项

- 必须先调用 `super.closedCallBack(e)`
- 通过 `e.getActionId()` 区分不同子页面的回调，避免混淆
- `e.getReturnData()` 可能为 null（用户未选择直接关闭），必须做空值判断
- 打开子页面时需要通过 `showParameter.setCloseCallBack()` 设置回调信息，否则不会触发此方法
- `CloseCallBack` 的第一个参数是当前插件实例（this），第二个参数是回调标识字符串
- 回填数据后，建议调用 `this.getView().updateView()` 刷新界面（如果数据未自动刷新）
