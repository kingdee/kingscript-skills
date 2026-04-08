# timerElapsed - 定时器轮询事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 页面定时器触发后回调 |
| 方法签名 | `timerElapsed(e: TimerElapsedArgs): void` |

## 说明

当页面或宿主已经开启定时器后，系统会按设定间隔回调 `timerElapsed`。这个事件适合做轻量刷新、看板轮询、超时检查，不适合在回调里执行耗时过长的逻辑。定时器的启动/停止入口要以当前版本 SDK 声明为准。

## 业务场景

销售看板页面每 30 秒轮询一次后台汇总结果，刷新待处理数量和预警提示，但不重新打开页面。

## 完整示例代码

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { TimerElapsedArgs } from "@cosmic/bos-core/kd/bos/form/events";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";

class SalesBoardTimerPlugin extends AbstractFormPlugin {

  afterBindData(e: $.java.util.EventObject): void {
    super.afterBindData(e);
    // 定时器启动入口需按当前版本 SDK 声明确认，这里不直接假设具体 API 名称。
  }

  timerElapsed(e: TimerElapsedArgs): void {
    const summary = QueryServiceHelper.queryOne(
      "bos_dashboard_summary",
      "todo_count,warning_count",
      NULL
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
    // 定时器移除入口需按当前版本 SDK 声明确认，这里不直接假设具体 API 名称。
  }
}

let plugin = new SalesBoardTimerPlugin();
export { plugin };
```

## 注意事项

- 定时器逻辑要尽量轻，避免回调堆积。
- 页面关闭或释放时要记得按当前版本 SDK 的真实入口移除定时器。
- 如果页面有手动刷新按钮，轮询与手动刷新最好共用同一段查询逻辑。
