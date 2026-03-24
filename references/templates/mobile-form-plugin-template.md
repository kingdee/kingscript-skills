# 移动表单插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractMobFormPlugin` 的移动表单插件
- 先搭好移动端表单骨架，再补充前端指令、定位、刷新和上传逻辑

## 基类

- `AbstractMobFormPlugin`

## 模板代码

```typescript
import { AbstractMobFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";

class MyPlugin extends AbstractMobFormPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于移动表单场景
- 按需补充 `beforeExecClientCmd`、`locate`、`refreshData` 等方法
- 需要移动端专有事件写法时，优先参考 `../examples/` 中的移动表单插件示例
