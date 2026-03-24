# 报表查询插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractReportListDataPlugin` 的报表查询插件
- 先搭好查询骨架，再补充查询条件、数据集返回和列定义逻辑

## 基类

- `AbstractReportListDataPlugin`

## 模板代码

```typescript
import { AbstractReportListDataPlugin } from "@cosmic/bos-core/kd/bos/entity/report";

class MyPlugin extends AbstractReportListDataPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是报表数据查询插件
- 按需补充 `query`、`getColumns` 等方法
- 需要数据集、过滤条件和列处理示例时，优先参考 `../examples/` 中的报表查询插件示例
