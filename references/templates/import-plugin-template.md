# 引入插件模板

## 适用场景

- 需要快速创建一个基于 `BatchImportPlugin` 的引入插件
- 先搭好导入骨架，再补充字段映射、默认导入类型和界面锁定逻辑

## 基类

- `BatchImportPlugin`

## 模板代码

```typescript
import { BatchImportPlugin } from "@cosmic/bos-core/kd/bos/form/plugin/impt";

class MyPlugin extends BatchImportPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是否属于批量引入场景
- 按需补充 `getOverrideFieldsConfig`、`getDefaultKeyFields` 等方法
- 需要导入参数和锁定界面示例时，优先参考 `../examples/` 中的引入插件示例
