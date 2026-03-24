# beforeBindData - 绑定数据前操作

来源：从 [表单插件.md](../表单插件.md) 拆出。

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 数据加载完成但尚未绑定到界面控件之前触发，可在绑定前对数据进行最后的调整 |
| 方法签名 | `beforeBindData(e: any): void` |

## 说明

在数据模型加载完毕、界面控件绑定数据之前触发的事件回调。此时数据模型中已有值，但尚未渲染到界面上，适合在绑定前对数据进行补充或修改，例如从外部系统获取数据并写入单据字段。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | EventObject | 事件参数对象，包含事件源信息 |

## 业务场景

在采购订单绑定数据前，根据单据头的币别从外部汇率系统查询最新汇率，并自动设置到单据头的汇率字段，同时根据汇率重新计算各分录行的本位币金额。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { QueryServiceHelper } from "@cosmic/bos-core/kd/bos/servicehelper";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

/**
 * 采购订单表单插件 - 绑定数据前查询汇率并设置
 */
class PmPurorderExchangeRatePlugin extends AbstractBillPlugIn {

  beforeBindData(e: any): void {
    super.beforeBindData(e);

    const currencyId = this.getModel().getValue("currency");
    if (currencyId == null) {
      return;
    }

    const orgId = this.getModel().getValue("org");
    if (orgId == null) {
      return;
    }

    const rateInfo = QueryServiceHelper.queryOne(
      "bd_exchangerate",
      "exchangerate",
      [
        new QFilter("sourcecurrency", "=", currencyId),
        new QFilter("targetcurrency.isbasecurrency", "=", true),
        new QFilter("org", "=", orgId),
        new QFilter("effectdate", "<=", new Date())
      ],
      "effectdate desc"
    );

    if (rateInfo != null) {
      const exchangeRate = rateInfo.get("exchangerate") as BigDecimal;
      this.getModel().setValue("exchangerate", exchangeRate);

      const rowCount = this.getModel().getEntryRowCount("billentry");
      for (let i = 0; i < rowCount; i++) {
        const originalAmount = this.getModel().getValue("amount", i) as BigDecimal;
        if (originalAmount != null) {
          const localAmount = originalAmount.multiply(exchangeRate)
            .setScale(2, BigDecimal.ROUND_HALF_UP);
          this.getModel().setValue("localamount", localAmount, i);
        }
      }

      let totalLocalAmount = BigDecimal.ZERO;
      for (let i = 0; i < rowCount; i++) {
        const localAmt = this.getModel().getValue("localamount", i) as BigDecimal;
        if (localAmt != null) {
          totalLocalAmount = totalLocalAmount.add(localAmt);
        }
      }
      this.getModel().setValue("totallocalamount", totalLocalAmount);
    }
  }
}

let plugin = new PmPurorderExchangeRatePlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.beforeBindData(e)` 以确保父类逻辑正常执行
- 此方法在数据绑定到界面之前触发，修改的值会直接反映到界面上
- 与 `afterBindData` 不同，此方法执行时界面控件尚未渲染，不适合做控件状态控制（如 setEnable、setVisible）
- 查询外部系统数据时注意性能，避免在此方法中执行耗时操作
- 新建单据和编辑单据都会触发此方法
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
- BigDecimal 的乘除运算需注意精度设置，使用 `setScale` 指定小数位数和舍入模式
