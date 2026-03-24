# beforeClosed - 关闭前操作

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 页面关闭之前触发，可在此向父页面回传数据或提示用户保存未提交的修改 |
| 方法签名 | `beforeClosed(e: BeforeClosedEvent): void` |

## 说明

在页面即将关闭时触发的事件回调。常用于弹窗页面关闭前将选中的数据回传给父页面，或在用户关闭编辑页面时提示未保存的修改。通过 `this.getView().returnDataToParent(data)` 将数据回传给父页面。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | BeforeClosedEvent | 关闭前事件参数对象 |

## 业务场景

自定义弹窗选择页面，用户在弹窗中勾选多条物料数据后点击确认关闭，将选中的物料信息回传给父页面（采购订单），父页面在 `closedCallBack` 中接收数据并填充到分录中。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeClosedEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { ClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/form/events";

/**
 * 物料选择弹窗插件 - 关闭前回传选中的物料数据给父页面
 */
class MaterialSelectDialogPlugin extends AbstractBillPlugIn {

  beforeClosed(e: BeforeClosedEvent): void {
    super.beforeClosed(e);

    const entryKey = "billentry";
    const rowCount = this.getModel().getEntryRowCount(entryKey);
    const selectedMaterials: any[] = [];

    for (let i = 0; i < rowCount; i++) {
      const isSelected = this.getModel().getValue("isselected", i) as boolean;

      if (isSelected) {
        const materialData: any = {};
        materialData.materialId = this.getModel().getValue("material", i);
        materialData.materialName = this.getModel().getValue("materialname", i);
        materialData.materialNumber = this.getModel().getValue("materialnumber", i);
        materialData.specification = this.getModel().getValue("specification", i);
        materialData.unitId = this.getModel().getValue("unit", i);
        materialData.price = this.getModel().getValue("price", i);
        materialData.qty = this.getModel().getValue("qty", i);

        selectedMaterials.push(materialData);
      }
    }

    if (selectedMaterials.length > 0) {
      this.getView().returnDataToParent(selectedMaterials);
    }
  }
}

let plugin = new MaterialSelectDialogPlugin();
export { plugin };
```

下面是父页面（采购订单）接收回传数据的配套代码：

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { ClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { FormShowParameter, ShowType, StyleCss, CloseCallBack } from "@cosmic/bos-core/kd/bos/form";

/**
 * 采购订单表单插件 - 打开物料选择弹窗并接收回传数据
 */
class PmPurorderMaterialSelectPlugin extends AbstractBillPlugIn {

  private openMaterialSelectDialog(): void {
    const fsp = new FormShowParameter();
    fsp.setFormId("custom_material_select");
    fsp.getOpenStyle().setShowType(ShowType.Modal);

    const css = new StyleCss();
    css.setWidth("960px");
    css.setHeight("580px");
    fsp.getOpenStyle().setInlineStyleCss(css);

    const closeCallBack = new CloseCallBack(plugin, "material_select");
    fsp.setCloseCallBack(closeCallBack);

    this.getView().showForm(fsp);
  }

  closedCallBack(e: ClosedCallBackEvent): void {
    super.closedCallBack(e);

    if (e.getActionId() === "material_select") {
      const returnData = e.getReturnData() as any[];
      if (returnData == null || returnData.length === 0) {
        return;
      }

      for (let i = 0; i < returnData.length; i++) {
        const materialData = returnData[i];
        const rowIndex = this.getModel().createNewEntryRow("billentry");
        this.getModel().setValue("material", materialData.materialId, rowIndex);
        this.getModel().setValue("unit", materialData.unitId, rowIndex);
        this.getModel().setValue("price", materialData.price, rowIndex);
        this.getModel().setValue("qty", materialData.qty, rowIndex);
      }

      this.getView().showSuccessNotification("已添加" + returnData.length + "条物料");
    }
  }
}

let plugin = new PmPurorderMaterialSelectPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.beforeClosed(e)` 以确保父类逻辑正常执行
- `this.getView().returnDataToParent(data)` 用于向父页面回传数据，父页面在 `closedCallBack` 中接收
- 回传的数据类型可以是任意可序列化对象，包括数组、对象等
- 父页面需要在打开弹窗时通过 `CloseCallBack` 设置回调标识，在 `closedCallBack` 中通过 `getActionId()` 匹配
- 如果弹窗中没有选中任何数据，建议不调用 `returnDataToParent` 或传回空标记，父页面做好空值判断
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
