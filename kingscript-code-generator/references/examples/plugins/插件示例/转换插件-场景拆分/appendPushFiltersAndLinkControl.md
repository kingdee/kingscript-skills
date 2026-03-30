# appendPushFiltersAndLinkControl - 下推前过滤与建链控制

## 场景

单据下推时，业务不希望所有来源行都能被继续下推。比如已锁定、已关闭、跨组织不匹配的来源行要提前挡掉；即便允许生成目标单，也可能要求某些场景不要建立源目标关联关系。

## Java 来源

- `kd.bos.plugin.sample.bill.billconvert.bizcase.BeforeBuildRowConditionSample`
- `kd.bos.plugin.sample.bill.billconvert.bizcase.BeforeCreateLinkSample`
- `kd.bos.plugin.sample.bill.billconvert.bizcase.AutoLinkSample`

## 适用入口

- `beforeBuildRowCondition(e: BeforeBuildRowConditionEventArgs): void`
- `beforeCreateLink(e: BeforeCreateLinkEventArgs): void`
- 插件基类：`AbstractConvertPlugIn`

## 完整 Kingscript 示例

```typescript
import { AbstractConvertPlugIn } from "@cosmic/bos-core/kd/bos/entity/botp/plugin";
import {
  BeforeBuildRowConditionEventArgs,
  BeforeCreateLinkEventArgs
} from "@cosmic/bos-core/kd/bos/entity/botp/plugin/args";
import { QCP, QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class AppendPushFiltersAndLinkControlPlugin extends AbstractConvertPlugIn {

  beforeBuildRowCondition(e: BeforeBuildRowConditionEventArgs): void {
    if (this.canPushLockedBill()) {
      return;
    }

    e.setCustFilterDesc("不允许下推已锁定且未审核的来源单据");
    e.setCustFilterExpression(" billstatus = 'A' and forbidstatus = 'A' ");

    e.getCustQFilters().add(new QFilter("billstatus", QCP.equals, "A"));
    e.getCustQFilters().add(new QFilter("forbidstatus", QCP.equals, "A"));
  }

  beforeCreateLink(e: BeforeCreateLinkEventArgs): void {
    if (this.shouldSkipLink()) {
      e.setCancel(true);
    }
  }

  private canPushLockedBill(): boolean {
    return false;
  }

  private shouldSkipLink(): boolean {
    return false;
  }
}

let plugin = new AppendPushFiltersAndLinkControlPlugin();
export { plugin };
```

## 映射说明

- `BeforeBuildRowConditionSample` 的重点不是“写一条固定表达式”，而是同时设置 3 样东西：说明文案、脚本表达式、查询层 `QFilter`。这里保留了这个三件套。
- `BeforeCreateLinkSample` 非常直接，就是按业务判断决定 `setCancel(true/false)`。这一层只负责“建不建链”，不要和“能不能下推”混成一个判断。
- `AutoLinkSample` 提醒了另一个边界：如果目标单不是标准下推生成，而是后续导入或补录，你可能还需要在目标单侧用 `afterImportData` 做补链。这里先把场景正文收敛在标准转换链路里，把导入补链作为延伸说明，而不是硬塞进同一个示例。

## 注意事项

- `setCustFilterExpression` 和 `getCustQFilters().add(...)` 最好保持语义一致，一个给脚本执行层，一个给数据查询层，缺一都容易出现“页面提示和实际可推数据不一致”。
- `beforeCreateLink` 只影响是否记录源目标关联，不一定影响目标数据是否生成，所以它不能代替前面的行过滤。
- 如果你的场景来自“目标单导入后补建来源关系”，那已经不属于纯转换插件时机，应该参考 `AutoLinkSample` 转到目标单插件侧处理。
