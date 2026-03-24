# 报表表单插件模板

## 适用场景

- 需要快速创建一个基于 `AbstractReportFormPlugin` 的报表表单插件
- 先搭好报表过滤面板或报表表单骨架，再补充默认查询参数、过滤条件和展示逻辑

## 基类

- `AbstractReportFormPlugin`

## 模板代码

```typescript
import { AbstractReportFormPlugin } from "@cosmic/bos-core/kd/bos/report/plugin";

class MyPlugin extends AbstractReportFormPlugin {



}

let plugin = new MyPlugin();

export { plugin };
```

## 使用说明

- 先确认当前需求是报表表单插件，而不是报表查询插件
- 按需补充 `initDefaultQueryParam` 等方法
- 需要完整报表插件链路时，配合 `../examples/` 中的报表表单插件示例一起看
