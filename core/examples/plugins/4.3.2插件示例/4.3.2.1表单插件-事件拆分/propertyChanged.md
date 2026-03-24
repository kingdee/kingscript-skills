# propertyChanged - 字段值改变事件

来源：从 [4.3.2.1表单插件.md](/E:/kingscript%20skills/kingscript-skill/core/examples/plugins/4.3.2%E6%8F%92%E4%BB%B6%E7%A4%BA%E4%BE%8B/4.3.2.1%E8%A1%A8%E5%8D%95%E6%8F%92%E4%BB%B6.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | IDataModelChangeListener |
| 触发时机 | 字段值被修改并写入数据模型之后触发 |
| 方法签名 | `propertyChanged(e: PropertyChangedArgs): void` |

## 说明

字段值变更后的回调事件，是最常用的联动计算入口。当用户在界面上修改字段值后触发，可在此实现字段间的联动计算、自动取值等逻辑。通过 `e.getChangeSet()` 获取所有变更记录。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | PropertyChangedArgs | 事件参数对象 |
| e.getChangeSet() | ChangeData[] | 获取所有变更记录集合 |
| change.getPropertyName() | string | 获取变更的字段标识 |
| change.getRowIndex() | number | 获取变更所在的分录行索引（单据头字段为 -1） |
| change.getNewValue() | any | 获取变更后的新值 |
| change.getOldValue() | any | 获取变更前的旧值 |

## 业务场景

销售订单中，当用户修改分录行的数量或单价时，自动计算该行的金额（数量 * 单价）、含税金额（金额 * (1 + 税率)）、税额（含税金额 - 金额），并汇总到单据头的合计字段。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { PropertyChangedArgs } from "@cosmic/bos-core/kd/bos/entity/datamodel/events";

/**
 * 销售订单表单插件 - 数量/单价变更时自动计算金额、含税金额、税额
 */
class SmSalorderCalcPlugin extends AbstractBillPlugIn {

  propertyChanged(e: PropertyChangedArgs): void {
    super.propertyChanged(e);

    let needRecalcTotal = false;

    for (const change of e.getChangeSet()) {
      const fieldKey = change.getPropertyName();
      const rowIndex = change.getRowIndex();

      if (fieldKey === "qty" || fieldKey === "price" || fieldKey === "taxrate") {
        this.calcRowAmounts(rowIndex);
        needRecalcTotal = true;
      }
    }

    // 有金额变化时统一汇总单据头
    if (needRecalcTotal) {
      this.recalcTotalAmounts();
    }
  }

  private calcRowAmounts(rowIndex: number): void {
    const qty = this.getModel().getValue("qty", rowIndex) as BigDecimal;
    const price = this.getModel().getValue("price", rowIndex) as BigDecimal;
    const taxRate = this.getModel().getValue("taxrate", rowIndex) as BigDecimal;

    if (qty == null || price == null) {
      return;
    }

    const amount = qty.multiply(price).setScale(2, BigDecimal.ROUND_HALF_UP);
    this.getModel().setValue("amount", amount, rowIndex);

    if (taxRate != null) {
      const taxRateDecimal = taxRate.divide(
        new BigDecimal("100"), 6, BigDecimal.ROUND_HALF_UP
      );

      const taxIncAmount = amount.multiply(
        BigDecimal.ONE.add(taxRateDecimal)
      ).setScale(2, BigDecimal.ROUND_HALF_UP);
      this.getModel().setValue("taxincamount", taxIncAmount, rowIndex);

      const taxAmount = taxIncAmount.subtract(amount);
      this.getModel().setValue("taxamount", taxAmount, rowIndex);
    }
  }

  private recalcTotalAmounts(): void {
    let totalAmount = BigDecimal.ZERO;
    let totalTaxIncAmount = BigDecimal.ZERO;
    let totalTaxAmount = BigDecimal.ZERO;
    const rowCount = this.getModel().getEntryRowCount("billentry");

    for (let i = 0; i < rowCount; i++) {
      const amount = this.getModel().getValue("amount", i) as BigDecimal;
      const taxIncAmount = this.getModel().getValue("taxincamount", i) as BigDecimal;
      const taxAmount = this.getModel().getValue("taxamount", i) as BigDecimal;

      if (amount != null) {
        totalAmount = totalAmount.add(amount);
      }
      if (taxIncAmount != null) {
        totalTaxIncAmount = totalTaxIncAmount.add(taxIncAmount);
      }
      if (taxAmount != null) {
        totalTaxAmount = totalTaxAmount.add(taxAmount);
      }
    }

    this.getModel().setValue("totalamount", totalAmount);
    this.getModel().setValue("totaltaxincamount", totalTaxIncAmount);
    this.getModel().setValue("totaltaxamount", totalTaxAmount);
  }
}

let plugin = new SmSalorderCalcPlugin();
export { plugin };
```

## 注意事项

- `e.getChangeSet()` 返回所有变更集合，每个变更包含字段名、行索引、新旧值
- `change.getRowIndex()` 获取变更所在的分录行索引，单据头字段返回 -1
- 除法运算必须指定精度和舍入模式（如 `BigDecimal.ROUND_HALF_UP`），否则会报错
- 联动计算中应避免无限循环：例如 A 字段改 B 字段、B 字段又改 A 字段会导致死循环
- 必须调用 `super.propertyChanged(e)` 以确保父类逻辑正常执行
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
