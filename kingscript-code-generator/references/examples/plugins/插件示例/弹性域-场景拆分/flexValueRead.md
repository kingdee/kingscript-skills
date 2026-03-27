# flexValueRead - 读取弹性域值对象

## 适用场景

单据保存前需要读取弹性域组合值，按维度做校验或日志输出。

## 核心对象

- `getValue(fieldKey)`
- `DynamicObject`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class FlexReadPlugin extends AbstractBillPlugIn {

  inspectFlexValue(): void {
    const flexValue = this.getModel().getValue("materialflex");
    if (flexValue == null) {
      return;
    }

    const flexNumber = flexValue.get("number");
    const flexName = flexValue.get("name");
    this.getView().showTipNotification(`弹性域值: ${flexNumber} / ${flexName}`);
  }
}

let plugin = new FlexReadPlugin();
export { plugin };
```

## 注意事项

- 弹性域值通常不是普通字符串，先确认拿到的是对象还是显示文本。
- 如果这里拿到的结构看不懂，回跳到 `FlexEntityType` 和 `FlexProperty`。
