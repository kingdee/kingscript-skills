# registerButtonAndControlListeners - 注册按钮与控件监听

## 场景

表单初始化后，需要同时监听工具栏按钮、普通按钮、单据体行点击和树节点点击，并在不同入口里做联动处理。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.form.bizcase.RegisterListenerSample`

这个 Java 样例展示了如何在一个 `registerListener` 里统一拿到多个控件并挂监听器。

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `itemClick(e: ItemClickEvent): void`
- `click(e: $.java.util.EventObject): void`
- `entryRowClick(e: $.kd.bos.form.control.events.RowClickEvent): void`
- `treeNodeClick(e: $.kd.bos.form.control.events.TreeNodeEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { Button, Control, Toolbar } from "@cosmic/bos-core/kd/bos/form/control";
import { ItemClickEvent } from "@cosmic/bos-core/kd/bos/form/control/events";

class RegisterListenersScenePlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    let toolbar = this.getView().getControl("tbmain") as Toolbar;
    toolbar.addItemClickListener(this);

    let button = this.getView().getControl("buttonap1") as Button;
    button.addClickListener(this);

    let entryGrid = this.getView().getControl("entryentity") as any;
    entryGrid.addRowClickEventListener(this);

    let treeView = this.getView().getControl("treeviewap1") as any;
    treeView.addTreeNodeClickListener(this);
  }

  itemClick(e: ItemClickEvent): void {
    super.itemClick(e);

    if (e.getItemKey() === "baritem_refresh") {
      this.getView().showTipNotification("工具栏刷新已触发。");
      this.getView().invokeOperation("refresh");
    }
  }

  click(e: $.java.util.EventObject): void {
    super.click(e);

    let control = e.getSource() as Control;
    if (control.getKey() === "buttonap1") {
      let billNo = this.getModel().getValue("billno") as string;
      this.getView().showMessage("当前单据编号：" + billNo);
    }
  }

  entryRowClick(e: $.kd.bos.form.control.events.RowClickEvent): void {
    let row = e.getRow();
    let materialName = this.getModel().getValue("materialname", row) as string;

    if (materialName != null && materialName !== "") {
      this.getView().showTipNotification("当前行物料：" + materialName);
    }
  }

  treeNodeClick(e: $.kd.bos.form.control.events.TreeNodeEvent): void {
    let nodeId = e.getNodeId();

    if (nodeId != null) {
      this.getModel().setValue("currentnodeid", nodeId);
    }
  }
}

let plugin = new RegisterListenersScenePlugin();
export { plugin };
```

## 映射说明

- Java 样例通过 `getView().getControl(key)` 拿到 `Toolbar`、`Button`、`EntryGrid`、`TreeView` 后再分别挂监听，Kingscript 里同样适合按控件类型拆开注册。
- 工具栏按钮点击优先进入 `itemClick`，普通按钮点击进入 `click`，单据体和树控件则进入各自的事件回调，这种“一个入口负责一类控件”的分工和 Java 一致。
- 对于单据体和树控件，案例保留了“注册在 `registerListener`，处理在专用回调”的写法，便于后续继续扩展更多监听器。

## 注意事项

- `registerListener` 里要先 `super.registerListener(e)`，再开始挂自定义监听。
- 监听注册前先确认控件标识和表单设计器里的 key 一致，否则事件不会触发。
- 一个插件里可以同时实现多种监听器，但建议每个回调只处理自己负责的控件类型。
- 单据体和树控件的事件回调更适合做联动展示；涉及大量数据处理时，建议抽到独立方法里，避免回调方法过长。
