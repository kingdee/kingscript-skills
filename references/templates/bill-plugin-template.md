# 单据插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractBillPlugIn` 的单据插件
- 先搭好插件骨架，再补充单据生命周期或字段事件逻辑

## 基类

- `AbstractBillPlugIn`

## 模板代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class MyPlugin extends AbstractBillPlugIn {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前场景是否属于单据插件
- 按需补充单据事件方法
- 字段 key、状态值和上下文对象都要以实际元数据为准
