# 后台任务插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractTask` 的后台任务插件
- 先搭好任务骨架，再补充任务标识、消息处理和停止逻辑

## 基类

- `AbstractTask`

## 模板代码

```typescript
import { AbstractTask } from "@cosmic/bos-core/kd/bos/schedule";

class MyPlugin extends AbstractTask {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于调度或后台任务场景
- 按需补充 `setTaskId`、`setMessageHandle`、`stop` 等方法
- 需要任务日志、消息处理和执行链路示例时，优先参考 `../examples/` 中的后台任务示例
