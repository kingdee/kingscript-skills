# 操作插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractOperationServicePlugIn` 的操作插件
- 先搭好插件骨架，再补充校验、准备字段或执行前后逻辑

## 基类

- `AbstractOperationServicePlugIn`

## 模板代码

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";

class Test extends AbstractOperationServicePlugIn {



}

let plugin = new Test();

export { plugin };
```

## 使用说明

- 先确认当前场景是否属于操作服务插件
- 按需补充 `onPreparePropertys`、`onAddValidators` 等方法
- 需要完整场景时优先回到 `../examples/` 查找对应示例
