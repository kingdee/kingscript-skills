# 采购订单选择供应商后自动回填联系信息

## 背景和业务目标

采购订单录单时，用户先选择供应商，再手工录入联系人、联系电话、收货地址、开户银行和银行账号，效率较低且容易录错。

目标是：

- 用户在采购订单中选择供应商后
- 自动回填供应商主数据里的常用联系信息
- 降低录单成本，减少人工错误

## 触发点和上下文

- 插件类型：单据插件
- 推荐基类：`AbstractBillPlugIn`
- 关键事件：
  - `registerListener`
  - `itemClick`
  - `closedCallBack`
- 关键上下文：
  - 当前页面能打开子页面
  - 关闭子页面时能通过回调把结果带回父页面

## 实现思路

1. 在页面上注册一个“选择供应商”的按钮点击事件
2. 点击后打开供应商选择页面
3. 通过 `CloseCallBack` 设置回调标识
4. 在 `closedCallBack` 中读取选中的供应商主键
5. 使用 `QueryServiceHelper.queryOne` 查询供应商详情
6. 把联系人、电话、地址、银行等信息回填到当前单据模型

## 关键代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { FormShowParameter, ShowType, CloseCallBack } from "@cosmic/bos-core/kd/bos/form";
import { ClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/form/events";

class PmPurorderSupplierFillPlugin extends AbstractBillPlugIn {

  registerListener(e: any): void {
    super.registerListener(e);
    this.addItemClickService("btn_select_supplier");
  }

  itemClick(e: any): void {
    super.itemClick(e);

    if (e.getItemKey() !== "btn_select_supplier") {
      return;
    }

    const showParameter = new FormShowParameter();
    showParameter.setFormId("bd_supplier");
    showParameter.getOpenStyle().setShowType(ShowType.Modal);
    showParameter.setCloseCallBack(new CloseCallBack(this, "select_supplier"));
    this.getView().showForm(showParameter);
  }

  closedCallBack(e: ClosedCallBackEvent): void {
    super.closedCallBack(e);

    if (e.getActionId() !== "select_supplier") {
      return;
    }

    const returnData = e.getReturnData();
    if (returnData == null) {
      return;
    }

    const supplierId = returnData.getPkValue();
    if (supplierId == null) {
      return;
    }

    const supplierInfo = QueryServiceHelper.queryOne(
      "bd_supplier",
      "name,contactperson,phone,address,bankname,bankaccount",
      [new QFilter("id", "=", supplierId)]
    );

    if (supplierInfo == null) {
      return;
    }

    this.getModel().setValue("supplier", supplierId);
    this.getModel().setValue("contactperson", supplierInfo.get("contactperson"));
    this.getModel().setValue("contactphone", supplierInfo.get("phone"));
    this.getModel().setValue("receiveaddress", supplierInfo.get("address"));
    this.getModel().setValue("bankname", supplierInfo.get("bankname"));
    this.getModel().setValue("bankaccount", supplierInfo.get("bankaccount"));
  }
}

let plugin = new PmPurorderSupplierFillPlugin();
export { plugin };
```

## 调用的 SDK 或开放能力

- `AbstractBillPlugIn`
- `FormShowParameter`
- `ShowType`
- `CloseCallBack`
- `ClosedCallBackEvent`
- `QueryServiceHelper`
- `QFilter`

## 踩坑记录

### 1. 只打开子页面，不设置关闭回调

如果没有调用 `showParameter.setCloseCallBack(...)`，子页面关闭后不会回到 `closedCallBack`，看起来就像“事件不触发”。

### 2. 没有区分不同回调来源

如果一个页面可能打开多个弹窗或 F7 选择界面，必须使用 `e.getActionId()` 区分来源，否则容易把不同弹窗的返回值处理混在一起。

### 3. 默认认为返回数据一定存在

用户可能直接关闭弹窗，不做选择。这时 `e.getReturnData()` 可能是 `null`，必须先判空。

### 4. 查询成功后忘记处理空字段

供应商资料并不一定每个字段都有值，回填前要允许空值存在，不要默认每个字段都能查到。

## 最终结论

这是一个很适合沉淀成标准范式的场景：

- “子页面打开 -> 回调返回 -> 查主数据 -> 回填当前单据”

后续如果遇到“选择客户后回填收货信息”“选择员工后回填部门信息”“选择物料后回填税率和默认仓库”这类需求，都可以复用同一思路。

## 相关文档

- [closedCallBack.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6-%E4%BA%8B%E4%BB%B6%E6%8B%86%E5%88%86/closedCallBack.md)
- [AbstractBillPlugIn.md](/E:/kingscript%20skills/kingscript-skill/core/sdk/classes/AbstractBillPlugIn.md)
- [troubleshooting.md](/E:/kingscript%20skills/kingscript-skill/core/docs/troubleshooting.md)
