# beforePackageData - 列表输出前补数据包

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractListPlugIn` |
| 触发时机 | 列表准备输出数据包前 |
| 方法签名 | `beforePackageData(e: BeforePackageDataEvent): void` |

## 说明

适合在列表最终输出前补充非基础资料字段、格式化展示值或压缩前端直接需要的附加字段。

## 业务场景

销售出库列表输出前，补一个只用于页面展示的“风险标记”字段，供前端高亮显示。

## 完整示例代码

```typescript
import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";
import { BeforePackageDataEvent } from "@cosmic/bos-core/kd/bos/entity/datamodel/events";

class DeliveryRiskFlagPlugin extends AbstractListPlugin {

  beforePackageData(e: BeforePackageDataEvent): void {
    super.beforePackageData(e);

    const dataEntitys = e.getPageData();
    for (let i = 0; i < dataEntitys.size(); i++) {
      const billStatus = dataEntitys.get(i).get("documentstatus");
      if (billStatus === "C") {
        dataEntitys.get(i).set("cust_riskflag", "HIGH");
      } else {
        dataEntitys.get(i).set("cust_riskflag", "NORMAL");
      }
    }
  }
}

let plugin = new DeliveryRiskFlagPlugin();
export { plugin };
```

## 注意事项

- 这个事件更适合补展示型字段，不要改基础资料引用属性
- 想改过滤条件时，优先看 `listBeforeBindData`
