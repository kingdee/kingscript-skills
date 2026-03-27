# 单据插件模板

## 适用场景

- 单据页面字段联动
- 分录增删改、F7 选择、操作前后校验

## 标准 import

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
```

## 模板代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeDoOperationEventArgs } from "@cosmic/bos-core/kd/bos/form/events";
import { PropertyChangedArgs } from "@cosmic/bos-core/kd/bos/entity/datamodel/events";

class MyPlugin extends AbstractBillPlugIn {

  propertyChanged(e: PropertyChangedArgs): void {
    super.propertyChanged(e);
  }

  beforeDoOperation(e: BeforeDoOperationEventArgs): void {
    super.beforeDoOperation(e);
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 先确认这是“单据表单”而不是普通表单。
- 如果问题是字段联动，优先补 `beforePropertyChanged`、`propertyChanged`、`beforeFieldPostBack`。
- 如果问题是保存、提交、审核，优先补 `beforeDoOperation`、`afterDoOperation`。

## 下一步去哪看

- 单据与表单综合示例：`../examples/plugins/插件示例/表单插件.md`
- 高频事件拆分：`../examples/plugins/插件示例/表单插件-事件拆分/README.md`
- 相关参数卡：`../sdk/packages/kd-bos-form-events.md`
