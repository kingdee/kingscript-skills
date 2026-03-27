# 后台任务插件模板

## 适用场景

- 调度任务、后台任务、长耗时异步处理

## 标准 import

```typescript
import { AbstractTask } from "@cosmic/bos-core/kd/bos/schedule";
```

## 模板代码

```typescript
import { AbstractTask } from "@cosmic/bos-core/kd/bos/schedule";

class MyPlugin extends AbstractTask {

  setTaskId(taskId: string): void {
    super.setTaskId(taskId);
  }

  stop(): void {
    super.stop();
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 后台任务要优先考虑任务标识、日志、消息处理和可停止性。
- 如果只是页面按钮点击后的即时逻辑，不要误用任务插件。
- 长耗时任务优先把输入参数设计成简单值，不要直接传页面对象。

## 下一步去哪看

- 后台任务示例：`../examples/plugins/插件示例/后台任务.md`
- 大任务示例：`../examples/plugins/插件示例/大任务插件.md`
