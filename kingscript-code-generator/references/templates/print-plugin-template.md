# 打印插件模板

## 适用场景

- 打印前后处理
- 打印数据包扩展
- 自定义打印数据加载

## 标准 import

```typescript
import { AbstractPrintPlugin } from "@cosmic/bos-core/kd/bos/print/core/plugin";
```

## 模板代码

```typescript
import { AbstractPrintPlugin } from "@cosmic/bos-core/kd/bos/print/core/plugin";
import { BeforeLoadDataEvent, CustomDataLoadEvent } from "@cosmic/bos-core/kd/bos/print/core/plugin/event";

class MyPlugin extends AbstractPrintPlugin {

  beforeLoadData(e: BeforeLoadDataEvent): void {
    super.beforeLoadData(e);
  }

  loadCustomData(e: CustomDataLoadEvent): void {
    super.loadCustomData(e);
  }
}

let plugin = new MyPlugin();

export { plugin };
```

## 起手建议

- 需要补打印模板数据时，先判断是页面阶段补数据，还是打印插件里补数据。
- 如果问题本质是“页面输出前加扩展字段”，也要同时看 `beforePackageData`。
- 打印逻辑尽量只关心输出数据，不要把页面交互逻辑混进来。

## 下一步去哪看

- 打印插件总览：`../examples/plugins/插件示例/打印插件.md`
- 打印数据包相关示例：`../examples/plugins/插件示例/表单插件-事件拆分/beforePackageData.md`
