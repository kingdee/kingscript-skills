# showMessagesAndConfirmCallback - 消息提示与确认回调

## 场景

用户点击表单上的不同按钮后，需要弹出普通消息、错误提示或确认框；当确认框关闭后，还要根据用户选择继续执行后续逻辑。

## Java 来源

- `kd.bos.plugin.sample.dynamicform.pcform.form.bizcase.ShowMessageSample`

这个 Java 样例覆盖了 `showMessage`、`showErrorNotification`、`showTipNotification`、`showConfirm` 和 `confirmCallBack` 的组合用法。

## 适用入口

- `registerListener(e: $.java.util.EventObject): void`
- `click(e: $.java.util.EventObject): void`
- `confirmCallBack(e: MessageBoxClosedEvent): void`
- 插件基类：`AbstractFormPlugin`

## 完整 Kingscript 示例

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { Control } from "@cosmic/bos-core/kd/bos/form/control";
import { ConfirmCallBackListener } from "@cosmic/bos-core/kd/bos/form";
import { MessageBoxClosedEvent } from "@cosmic/bos-core/kd/bos/form/events";
import { MessageBoxOptions, MessageBoxResult } from "@cosmic/bos-core/kd/bos/form";

class FormMessageScenePlugin extends AbstractFormPlugin {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    this.addClickListeners(
      "btn_show_message",
      "btn_show_error",
      "btn_delete_row"
    );
  }

  click(e: $.java.util.EventObject): void {
    super.click(e);

    let control = e.getSource() as Control;
    let key = control.getKey();

    if (key === "btn_show_message") {
      this.getView().showMessage("当前单据已加载完成，可以继续录入。");
      return;
    }

    if (key === "btn_show_error") {
      this.getView().showErrorNotification("当前数据存在未处理异常，请先修正后再继续。");
      return;
    }

    if (key === "btn_delete_row") {
      let row = this.getModel().getEntryCurrentRowIndex("entryentity");
      if (row < 0) {
        this.getView().showTipNotification("请先选中一行分录。");
        return;
      }

      let materialName = this.getModel().getValue("materialname", row) as string;
      this.getView().showConfirm(
        "确认删除分录【" + materialName + "】吗？",
        MessageBoxOptions.YesNo,
        new ConfirmCallBackListener("delete_entry_confirm", this)
      );
    }
  }

  confirmCallBack(e: MessageBoxClosedEvent): void {
    super.confirmCallBack(e);

    if (e.getCallBackId() !== "delete_entry_confirm") {
      return;
    }

    if (e.getResult() !== MessageBoxResult.Yes) {
      this.getView().showTipNotification("已取消删除。");
      return;
    }

    let row = this.getModel().getEntryCurrentRowIndex("entryentity");
    if (row >= 0) {
      this.getModel().deleteEntryRow("entryentity", row);
      this.getView().updateView("entryentity");
      this.getView().showMessage("分录已删除。");
    }
  }
}

let plugin = new FormMessageScenePlugin();
export { plugin };
```

## 映射说明

- Java 样例里把多个按钮统一注册到 `registerListener`，在 Kingscript 里同样可以集中使用 `addClickListeners([...])`。
- Java 里的 `Control.getKey()` 分支判断，适合直接映射成 `click` 方法里按控件标识分流。
- Java 里通过 `ConfirmCallBackListener(callbackId, this)` 绑定回调；Kingscript 也沿用同样的回调 ID 思路，用 `confirmCallBack` 区分不同确认场景。
- Java 还演示了多种 `showMessage/showConfirm` 重载。这里优先保留本地参考里已经能稳定确认的常用写法，避免把不常用的重载全部搬进案例。

## 注意事项

- `showConfirm` 是异步交互，确认结果不会在当前 `click` 方法里同步返回，而是进入 `confirmCallBack`。
- 不同确认场景要使用不同的回调 ID，否则在 `confirmCallBack` 里很难区分来源。
- 页面提示优先走 `this.getView()`；数据修改优先走 `this.getModel()`，不要把视图能力和模型能力混用。
- 如果只是普通提示，优先用 `showMessage`、`showTipNotification`、`showErrorNotification` 这些已在本地参考里确认的能力。
