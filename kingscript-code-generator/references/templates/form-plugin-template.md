# 表单插件模板

## 适用场景

- 普通表单页面、看板页面、查询页面
- 需要处理页面生命周期、字段回传、关闭回调、定时器

## 标准 import

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
```

## 模板代码

```typescript
import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { AfterBindDataEvent, ClosedCallBackEvent } from "@cosmic/bos-core/kd/bos/form/events";

class MyPlugin extends AbstractFormPlugin {

  afterBindData(e: AfterBindDataEvent): void {
    super.afterBindData(e);
  }

  closedCallBack(e: ClosedCallBackEvent): void {
    super.closedCallBack(e);
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 先确认当前需求是不是“页面插件”而不是“单据插件”或“列表插件”。
- 初次起手通常从 `afterBindData`、`closedCallBack`、`beforeClosed` 里挑最相关的 1-2 个方法。
- 需要页面轮询、关闭回调、水印、权限前置时，再按需补其他方法。

## 下一步去哪看

- 生命周期和页面能力：`../examples/plugins/插件示例/表单插件-事件拆分/README.md`
- SDK 参数语义：`../sdk/packages/kd-bos-form-events.md`
