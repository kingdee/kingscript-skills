# beforePropertyChanged - 字段值改变前事件

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | IDataModelChangeListener |
| 触发时机 | 字段值被修改之前触发，可在此拦截并取消修改操作 |
| 方法签名 | `beforePropertyChanged(e: any): void` |

## 说明

在字段值实际写入数据模型之前触发的事件回调。通过该方法可以获取字段的新值和旧值，进行前置校验，若不满足业务规则可调用 `e.setCancel(true)` 阻止本次修改。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | BeforePropertyChangedArgs | 事件参数对象 |
| e.getPropertyName() | string | 获取被修改的字段标识 |
| e.getNewValue() | any | 获取即将设置的新值 |
| e.getOldValue() | any | 获取修改前的旧值 |
| e.getRowIndex() | number | 获取分录行索引（单据头字段为 -1） |
| e.setCancel(boolean) | void | 设置为 true 可取消本次修改 |

## 业务场景

采购订单中，单价修改前校验是否允许修改。当单据已审核时，不允许修改单价字段，防止已审核的采购订单被随意调价。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

/**
 * 采购订单表单插件 - 已审核单据不允许修改单价
 */
class PmPurorderPriceCheckPlugin extends AbstractBillPlugIn {

  beforePropertyChanged(e: any): void {
    super.beforePropertyChanged(e);

    const fieldKey = e.getPropertyName();

    // 仅拦截单价字段的修改
    if (fieldKey === "price") {
      // 获取单据头的审核状态
      const billStatus = this.getModel().getValue("billstatus") as string;

      // C 表示已审核状态
      if (billStatus === "C") {
        // 阻止修改
        e.setCancel(true);
        this.getView().showWarnNotification("已审核的采购订单不允许修改单价");
        return;
      }

      // 额外校验：新单价不能为负数
      const newPrice = e.getNewValue() as BigDecimal;
      if (newPrice != null && newPrice.compareTo(BigDecimal.ZERO) < 0) {
        e.setCancel(true);
        this.getView().showWarnNotification("单价不能为负数");
        return;
      }
    }
  }
}

let plugin = new PmPurorderPriceCheckPlugin();
export { plugin };
```

## 注意事项

- `e.getNewValue()` 获取即将设置的新值，`e.getOldValue()` 获取修改前的旧值
- `e.setCancel(true)` 可阻止本次字段值变更，界面上的值会恢复为修改前的状态
- 此方法在值实际写入数据模型前触发，适合做前置校验拦截
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
- 必须调用 `super.beforePropertyChanged(e)` 以确保父类逻辑正常执行
