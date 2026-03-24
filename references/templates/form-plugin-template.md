# 表单插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractFormPlugin` 的表单插件
- 先搭好插件骨架，再补充事件方法和业务逻辑

## 基类

- `AbstractFormPlugin`

## 模板代码

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";

class MyPlugin extends AbstractFormPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前场景是否属于表单插件
- 按需补充对应事件方法
- 业务逻辑优先参考 `../examples/` 中最接近的示例
