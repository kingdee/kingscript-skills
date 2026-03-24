# 列表插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractListPlugin` 的列表插件
- 先搭好插件骨架，再补充列表交互和展示逻辑

## 基类

- `AbstractListPlugin`

## 模板代码

```typescript
import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";

class MyPlugin extends AbstractListPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前场景是否属于列表插件
- 按需补充列表事件或操作逻辑
- 需要具体写法时优先参考 `../examples/` 中的列表插件示例
