# timerElapsed - 定时器轮询事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 页面定时器触发后回调 |
| 方法签名 | `timerElapsed(e: TimerElapsedArgs): void` |

## 说明

当页面通过视图能力开启定时器后，系统会按设定间隔回调 `timerElapsed`。这个事件适合做轻量刷新、看板轮询、超时检查，不适合在回调里执行耗时过长的逻辑。

## 业务场景

销售看板页面每 30 秒轮询一次后台汇总结果，刷新待处理数量和预警提示，但不重新打开页面。

## 完整示例代码

```typescript
import { AbstractFormPlugIn } from "@cosmic/bos-core/kd/bos/form/plugin";
import { TimerElapsedArgs } from "@cosmic/bos-core/kd/bos/form/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class SalesBoardTimerPlugin extends AbstractFormPlugIn {

  afterBindData(e: $.java.util.EventObject): void {
    super.afterBindData(e);
    this.getView().startTimer(30000);
  }

  timerElapsed(e: TimerElapsedArgs): void {
    super.timerElapsed(e);

    const summary = QueryServiceHelper.queryOne(
      "bos_dashboard_summary",
      "todo_count,warning_count",
      null
    );

    if (summary != null) {
      this.getModel().setValue("ftodoqty", summary.get("todo_count"));
      this.getModel().setValue("fwarningqty", summary.get("warning_count"));
      this.getView().updateView("ftodoqty");
      this.getView().updateView("fwarningqty");
    }
  }

  pageRelease(e: $.java.util.EventObject): void {
    super.pageRelease(e);
    this.getView().stopTimer();
  }
}

let plugin = new SalesBoardTimerPlugin();
export { plugin };
```

## 注意事项

- 定时器逻辑要尽量轻，避免回调堆积。
- 页面关闭或释放时要记得停止定时器。
- 如果页面有手动刷新按钮，轮询与手动刷新最好共用同一段查询逻辑。
