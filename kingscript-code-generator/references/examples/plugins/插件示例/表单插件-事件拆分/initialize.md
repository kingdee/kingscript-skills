# initialize - 初始化事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 插件初始化时触发，是插件生命周期中最早执行的方法之一 |
| 方法签名 | `initialize(): void` |

## 说明

插件的初始化方法，在表单生命周期的最早阶段执行。用于进行非UI相关的初始化操作，如注册工具栏按钮、初始化配置参数等。此时数据模型和界面控件可能尚未完全就绪，因此不建议在此方法中操作数据或控件。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| 无 | - | 该方法不接收参数 |

## 业务场景

表单初始化时，注册自定义工具栏按钮并绑定点击事件。在采购订单表单中，根据当前用户角色动态添加工具栏按钮，如"批量询价"、"价格对比"、"供应商评估"等自定义功能按钮，并在后续的 `registerListener` 中绑定点击事件。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { ItemClickEvent } from "@cosmic/bos-core/kd/bos/form/control/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";
import { RequestContext } from "@cosmic/bos-core/kd/bos/context";

/**
 * 采购订单表单插件 - 初始化时注册自定义工具栏按钮
 */
class PmPurorderToolbarPlugin extends AbstractBillPlugIn {

  initialize(): void {
    super.initialize();

    // 在初始化阶段添加自定义工具栏按钮
    const toolBar = this.getView().getControl("tbmain");

    if (toolBar != null) {
      // 添加"批量询价"按钮
      toolBar.addButton(
        "btn_batch_inquiry",
        "批量询价",
        "icon-inquiry"
      );

      // 添加"价格对比"按钮
      toolBar.addButton(
        "btn_price_compare",
        "价格对比",
        "icon-compare"
      );

      // 根据用户角色决定是否显示"供应商评估"按钮
      const currentUserId = RequestContext.get().getCurrUserId();
      const isManager = QueryServiceHelper.queryOne(
        "sys_user_role",
        "id",
        [
          new QFilter("user", "=", currentUserId),
          new QFilter("role.number", "=", "purchase_manager")
        ]
      );

      if (isManager != null) {
        // 仅采购经理可看到供应商评估按钮
        toolBar.addButton(
          "btn_supplier_evaluate",
          "供应商评估",
          "icon-evaluate"
        );
      }
    }
  }

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    // 注册工具栏按钮点击监听
    this.addItemClickService("btn_batch_inquiry");
    this.addItemClickService("btn_price_compare");
    this.addItemClickService("btn_supplier_evaluate");
  }

  itemClick(e: ItemClickEvent): void {
    super.itemClick(e);

    const itemKey = e.getItemKey();

    if (itemKey === "btn_batch_inquiry") {
      // 批量询价：收集分录中所有物料，打开询价界面
      const rowCount = this.getModel().getEntryRowCount("billentry");
      if (rowCount === 0) {
        this.getView().showTipNotification("请先添加物料分录");
        return;
      }

      const materialIds: any[] = [];
      for (let i = 0; i < rowCount; i++) {
        const materialId = this.getModel().getValue("material", i);
        if (materialId != null) {
          materialIds.push(materialId);
        }
      }

      // 打开询价界面并传入物料列表
      const showParameter = new (this as any).FormShowParameter();
      showParameter.setFormId("pm_inquiry");
      showParameter.getCustomParams().put("materialIds", JSON.stringify(materialIds));

      this.getView().showForm(showParameter);
    }

    if (itemKey === "btn_price_compare") {
      // 价格对比：查询各供应商报价
      const rowIndex = this.getModel().getEntryCurrentRowIndex("billentry");
      if (rowIndex < 0) {
        this.getView().showTipNotification("请先选择一行物料");
        return;
      }

      const materialId = this.getModel().getValue("material", rowIndex);
      if (materialId == null) {
        this.getView().showTipNotification("当前行未选择物料");
        return;
      }

      // 查询该物料的各供应商报价
      const priceList = QueryServiceHelper.query(
        "pm_pricelist",
        "supplier.name as suppliername,price,currency.name as currencyname,updatetime",
        [
          new QFilter("material", "=", materialId),
          new QFilter("usestatus", "=", 1)
        ]
      );

      if (priceList == null || priceList.size() === 0) {
        this.getView().showTipNotification("未找到该物料的供应商报价记录");
        return;
      }

      // 构建价格对比信息
      let priceInfo = "物料报价对比：\n";
      while (priceList.next()) {
        const supplierName = priceList.getString("suppliername");
        const price = priceList.getBigDecimal("price");
        const currencyName = priceList.getString("currencyname");
        priceInfo += supplierName + ": " + currencyName + " " + price.toString() + "\n";
      }

      this.getView().showTipNotification(priceInfo);
    }

    if (itemKey === "btn_supplier_evaluate") {
      // 供应商评估：打开供应商评估表单
      const supplierId = this.getModel().getValue("supplier");
      if (supplierId == null) {
        this.getView().showTipNotification("请先选择供应商");
        return;
      }

      const showParameter = new (this as any).FormShowParameter();
      showParameter.setFormId("pm_supplier_evaluate");
      showParameter.getCustomParams().put("supplierId", supplierId.toString());

      this.getView().showForm(showParameter);
    }
  }
}

let plugin = new PmPurorderToolbarPlugin();
export { plugin };
```

## 注意事项

- `initialize` 是插件生命周期中最早执行的方法之一，必须先调用 `super.initialize()`
- 此阶段适合进行非UI相关的初始化操作，如注册工具栏按钮、初始化配置
- 不建议在此方法中操作数据模型（`this.getModel()`），因为数据可能尚未加载
- 界面控件的事件监听应在 `registerListener` 中注册，而非 `initialize`
- 动态添加的按钮需要在 `registerListener` 中注册点击监听，否则点击事件不会触发
- 插件类不能有类属性（如 `private xxx = ...`），只使用局部变量
