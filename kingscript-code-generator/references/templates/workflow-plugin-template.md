# 工作流插件模板

## 适用场景

- 需要快速创建一个基于 `WorkflowPlugin` 的工作流插件
- 先搭好工作流骨架，再补充参与人计算、条件判断和通知逻辑

## 基类

- `WorkflowPlugin`

## 模板代码

```typescript
import { WorkflowPlugin } from "@cosmic/bos-core/kd/bos/workflow/engine/extitf";

class MyPlugin extends WorkflowPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于工作流扩展点
- 按需补充 `calcUserIds`、`hasTrueCondition`、`notify` 等方法
- 需要审批流对象和通知示例时，优先参考 `../examples/` 中的工作流插件示例
