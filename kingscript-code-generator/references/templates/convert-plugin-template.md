# 转换插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractConvertPlugIn` 的转换插件
- 先搭好转换插件骨架，再补充目标单据创建、字段映射和转换后处理逻辑

## 基类

- `AbstractConvertPlugIn`

## 模板代码

```typescript
import { AbstractConvertPlugIn } from "@cosmic/bos-core/kd/bos/entity/botp/plugin";

class MyPlugin extends AbstractConvertPlugIn {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于单据转换场景
- 按需补充 `afterCreateTarget`、`afterFieldMapping`、`afterConvert` 等方法
- 需要具体转换时机和参数写法时，优先参考 `../examples/` 中的转换插件示例
