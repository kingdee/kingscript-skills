# 打印插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractPrintPlugin` 的打印插件
- 先搭好打印骨架，再补充打印前、加载后和自定义数据处理逻辑

## 基类

- `AbstractPrintPlugin`

## 模板代码

```typescript
import { AbstractPrintPlugin } from "@cosmic/bos-core/kd/bos/print/core/plugin";

class MyPlugin extends AbstractPrintPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于打印扩展场景
- 按需补充 `beforeLoadData`、`afterLoadData`、`loadCustomData` 等方法
- 需要具体打印事件写法时，优先参考 `../examples/` 中的打印插件示例
