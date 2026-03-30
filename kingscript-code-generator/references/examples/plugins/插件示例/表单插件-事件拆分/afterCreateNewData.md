# afterCreateNewData - 数据包创建之后事件

来源：从 [表单插件.md](../表单插件.md) 中抽出并按当前声明层收紧参数类型。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | IDataModelListener |
| 触发时机 | 新建单据数据包创建完成后触发，在 `createNewData` 之后执行 |
| 方法签名 | `afterCreateNewData(e: $.java.util.EventObject): void` |

## 说明

在新建单据的数据包已经创建完成之后触发。此时通常已经可以通过 `this.getModel()` 做默认值补齐、默认分录初始化等后置处理。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | `$.java.util.EventObject` | 事件对象；当前声明层未给出更具体的导出事件类型 |

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class DemoAfterCreateNewDataPlugin extends AbstractBillPlugIn {

  afterCreateNewData(e: $.java.util.EventObject): void {
    super.afterCreateNewData(e);

    this.getModel().setValue("fieldA", 123);
  }
}

let plugin = new DemoAfterCreateNewDataPlugin();

export { plugin };
```

## 注意事项

- 当前版本声明层对 `afterCreateNewData` 给出的参数类型是 `$.java.util.EventObject`，不要偷懒写成 `any`
- 如果后续需要调用 `e` 上的方法，必须先确认这些方法属于 `$.java.util.EventObject` 或当前版本补充的继承链
- 此事件更适合做模型已建立后的默认值补齐；底层数据包构造优先放在 `createNewData`
