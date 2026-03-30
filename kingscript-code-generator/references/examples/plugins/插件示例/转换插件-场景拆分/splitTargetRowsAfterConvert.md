# splitTargetRowsAfterConvert - 转换后按数量拆分目标数据

## 场景

源单下推后，目标单已经生成出来了，但业务要求“数量 3 不能只生成 1 行目标数据”，而是要把目标卡片或目标分录按数量拆开；同时还希望在拆分前读取来源行上的单号或关键字段，带到目标数据里。

## Java 来源

- `kd.bos.plugin.sample.bill.billconvert.bizcase.AfterCreateTargetSample`
- `kd.bos.plugin.sample.bill.billconvert.bizcase.AfterConvertSample`

## 适用入口

- `afterCreateTarget(e: AfterCreateTargetEventArgs): void`
- `afterConvert(e: AfterConvertEventArgs): void`
- 插件基类：`AbstractConvertPlugIn`

## 完整 Kingscript 示例

```typescript
import { ExtendedDataEntity } from "@cosmic/bos-core/kd/bos/entity";
import { AbstractConvertPlugIn } from "@cosmic/bos-core/kd/bos/entity/botp/plugin";
import {
  AfterConvertEventArgs,
  AfterCreateTargetEventArgs
} from "@cosmic/bos-core/kd/bos/entity/botp/plugin/args";
import { DynamicObject } from "@cosmic/bos-core/kd/bos/dataentity/entity";
import { OrmUtils } from "@cosmic/bos-core/kd/bos/dataentity/utils";
import { ArrayList } from "@cosmic/bos-script/java/util";

class SplitTargetRowsAfterConvertPlugin extends AbstractConvertPlugIn {

  afterCreateTarget(e: AfterCreateTargetEventArgs): void {
    let entryRows = e.getTargetExtDataEntitySet().FindByEntityKey("entryentity");
    let billNoProp = e.getFldProperties().get("billno");

    for (let i = 0; i < entryRows.length; i++) {
      let entryRow = entryRows[i];
      let sourceRows = entryRow.getValue("ConvertSource") as $.java.util.List;
      if (sourceRows == null || sourceRows.size() === 0 || billNoProp == null) {
        continue;
      }

      let sourceBillNo = billNoProp.getValue(sourceRows.get(0)) as string;
      entryRow.setValue("memo", "来源单号：" + sourceBillNo);
    }
  }

  afterConvert(e: AfterConvertEventArgs): void {
    let targetCards = e.getTargetExtDataEntitySet().FindByEntityKey("fa_card_real");
    let nextDataIndex = targetCards.length;
    let copiedCards = new ArrayList();

    for (let i = 0; i < targetCards.length; i++) {
      let card = targetCards[i];
      let qty = card.getValue("assetamount") as number;
      if (qty == null || qty <= 1) {
        continue;
      }

      card.setValue("assetamount", 1);

      let splitSeq = 1;
      card.setValue("sourceentrysplitseq", splitSeq++);

      for (let copyIndex = 1; copyIndex < qty; copyIndex++) {
        let copiedData = OrmUtils.clone(card.getDataEntity(), false, true) as DynamicObject;
        copiedData.set("assetamount", 1);
        copiedData.set("sourceentrysplitseq", splitSeq++);

        copiedCards.add(new ExtendedDataEntity(copiedData, nextDataIndex++, 0));
      }
    }

    if (copiedCards.size() > 0) {
      e.getTargetExtDataEntitySet().AddExtendedDataEntities("fa_card_real", copiedCards);
    }
  }
}

let plugin = new SplitTargetRowsAfterConvertPlugin();
export { plugin };
```

## 映射说明

- `AfterCreateTargetSample` 演示的是“目标数据刚生成出来时，如何拿到来源行再取字段值”；这里把它落成了给目标分录补 `memo` 的完整业务动作。
- `AfterConvertSample` 的核心是遍历 `fa_card_real`，把数量改成 1，再复制出额外的 `ExtendedDataEntity`。这里保留了这一整条链路，只把变量名和说明换成更容易读的形式。
- 两个事件放在同一篇案例里，是为了回答更完整的问题：先在生成后读取来源信息，再在转换最终结果上做拆分，而不是把两个片段拆散让用户自己拼。

## 注意事项

- `afterCreateTarget` 更适合读取来源数据、给目标对象补标记；真正增删目标结果，通常放到 `afterConvert` 更稳妥。
- 复制目标数据时要维护新的数据索引，否则新增的扩展实体可能和已有结果冲突。
- 拆分数量类场景一定要先把原记录的数量改成 1，再复制剩余份数，否则最终总量会翻倍。
