# flexDisplayText - 获取弹性域显示文本

## 适用场景

页面提示、日志记录、单据状态说明里需要把弹性域对象转成更容易读的文本。

## 核心对象

- `getDataEntity()`
- `DynamicObject`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class FlexDisplayPlugin extends AbstractBillPlugIn {

  showFlexText(): void {
    const bill = this.getModel().getDataEntity();
    const flexValue = bill.get("materialflex");
    if (flexValue == null) {
      return;
    }

    const displayText = flexValue.get("name");
    this.getView().showTipNotification(`当前弹性域显示值: ${displayText}`);
  }
}

let plugin = new FlexDisplayPlugin();
export { plugin };
```

## 注意事项

- “显示值”只是为了界面友好，不一定是最终存储主键。
- 列表、报表里经常需要在数据包阶段提前补这类显示字段。
