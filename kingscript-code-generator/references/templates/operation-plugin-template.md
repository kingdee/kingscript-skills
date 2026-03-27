# 操作插件模板

## 适用场景

- 服务端操作前校验
- 准备属性、补校验器、操作事务前后逻辑

## 标准 import

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";
```

## 模板代码

```typescript
import { AbstractOperationServicePlugIn } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { AddValidatorsEventArgs, PreparePropertysEventArgs } from "@cosmic/bos-core/kd/bos/entity/plugin/args";

class MyPlugin extends AbstractOperationServicePlugIn {

  onPreparePropertys(e: PreparePropertysEventArgs): void {
    super.onPreparePropertys(e);
  }

  onAddValidators(e: AddValidatorsEventArgs): void {
    super.onAddValidators(e);
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 需要控制服务端操作行为时，再选这个模板，不要和页面插件混用。
- 只需要前置校验时，通常先补 `onAddValidators`。
- 需要补齐字段、减少后续查询时，通常先补 `onPreparePropertys`。

## 下一步去哪看

- 操作插件事件拆分：`../examples/plugins/插件示例/操作插件-事件拆分/README.md`
- SDK 检索入口：`../sdk/indexes/plugin-index.md`
