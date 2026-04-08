# cancelOperationBeforeTransaction - 事务前校验与中断操作

## 场景

服务端操作插件在真正进入事务前，需要先筛掉不合法的单据；如果所有单据都不合法，则直接取消操作，并把错误写入操作结果，避免无意义地进入事务。

## Java 来源

- `kd.bos.plugin.sample.bill.bizoperation.bizcase.BeforeExecuteOperationTransactionSample`

这个 Java 样例展示了三步：遍历 `getValidExtDataEntities()`、把不通过的数据剔除并写错误、如果最终一个有效单据都没有则取消操作。

## 适用入口

- `onPreparePropertys(e: PreparePropertysEventArgs): void`
- `beforeExecuteOperationTransaction(e: BeforeOperationArgs): void`
- 插件基类：`AbstractOperationServicePlugIn`

## 完整 Kingscript 示例

```typescript

import { AbstractOperationServicePlugIn, PreparePropertysEventArgs } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { BeforeOperationArgs } from "@cosmic/bos-core/kd/bos/entity/plugin/args";
import { ErrorLevel, ValidationErrorInfo } from "@cosmic/bos-core/kd/bos/entity/validate";
import { ArrayList } from "@cosmic/bos-script/java/util";

class BeforeTransactionScenePlugin extends AbstractOperationServicePlugIn {

  onPreparePropertys(e: PreparePropertysEventArgs): void {
    let fieldKeys = e.getFieldKeys();
    fieldKeys.add("deliverydate");
    fieldKeys.add("lastdate");
    fieldKeys.add("billno");
  }

  beforeExecuteOperationTransaction(e: BeforeOperationArgs): void {
    super.beforeExecuteOperationTransaction(e);

    let filteredList = new ArrayList();
    let validExtDatas = e.getValidExtDataEntities();

    for (let i = 0; i < validExtDatas.size(); i++) {
      let extData = validExtDatas.get(i);
      let dataEntity = extData.getDataEntity();
      let deliveryDate = dataEntity.get("deliverydate") as Date;
      let lastDate = dataEntity.get("lastdate") as Date;

      if (deliveryDate != null && lastDate != null && deliveryDate.getTime() <= lastDate.getTime()) {
        filteredList.add(extData);
        continue;
      }

      let info = new ValidationErrorInfo(
        "",
        extData.getBillPkId(),
        extData.getDataEntityIndex(),
        extData.getRowIndex(),
        "DELIVERY_DATE_CHECK",
        "送货日期检查",
        "预计送货日期不能晚于最迟送货日期。",
        ErrorLevel.Error
      );
      this.getOperationResult().addErrorInfo(info);
    }

    validExtDatas.clear();
    validExtDatas.addAll(filteredList);

    if (filteredList.isEmpty()) {
      e.setCancel(true);
    }
  }
}

let plugin = new BeforeTransactionScenePlugin();
export { plugin };
```

## 映射说明

- Java 样例不是简单 `throw` 异常，而是先过滤有效单据，再把错误追加到操作结果中；这里保留了这种“部分通过、部分剔除”的思路。
- `onPreparePropertys` 在这个场景里依然必需，因为事务前校验要读取 `deliverydate` 和 `lastdate`。
- 当过滤后没有任何有效单据时，Java 样例会把操作整体取消；这里对应使用 `e.setCancel(true)`。

## 注意事项

- `beforeExecuteOperationTransaction` 发生在事务真正开启前，适合做批量预筛选和最终一致性校验。
- 如果你只想做标准的字段规则校验，通常优先考虑 `onAddValidators`；只有当逻辑涉及“筛掉一部分单据再继续执行”时，再把它放到这里。
- 这里写入的是操作结果错误信息，不是页面提示；调用方最终看到的是服务端操作失败或部分失败结果。
- 这类逻辑要按“多单据批量处理”去思考，不能默认一次只处理一张单据。
