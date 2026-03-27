# 列表插件模板

## 适用场景

- 列表默认过滤、选择联动、从列表打开单据后的回调处理

## 标准 import

```typescript
import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";
```

## 模板代码

```typescript
import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";
import { DataSelectEvent, ListBeforeBindDataEvent } from "@cosmic/bos-core/kd/bos/list/events";

class MyPlugin extends AbstractListPlugin {

  listBeforeBindData(e: ListBeforeBindDataEvent): void {
    super.listBeforeBindData(e);
  }

  dataSelect(e: DataSelectEvent): void {
    super.dataSelect(e);
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 列表初始化问题优先从 `listBeforeBindData` 开始。
- 选中行驱动按钮状态、批量操作可用性时优先补 `dataSelect`。
- 从列表打开单据再返回列表时，优先补 `billClosedCallBack`。

## 下一步去哪看

- 列表拆分示例：`../examples/plugins/插件示例/列表插件-事件拆分/README.md`
- 列表总览：`../examples/plugins/插件示例/列表插件.md`
- 相关参数卡：`../sdk/packages/kd-bos-list-events.md`
