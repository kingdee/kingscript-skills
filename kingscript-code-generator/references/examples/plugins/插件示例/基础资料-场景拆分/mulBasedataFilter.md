# mulBasedataFilter - 多选基础资料控件过滤

## 适用场景

限制多选基础资料的可选范围，比如只允许选择当前组织下已启用的辅助资料。

## 核心对象

- `MulBasedataEdit`
- `QFilter`

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { MulBasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class MultiAssistantFilterPlugin extends AbstractBillPlugIn {

  configAssistantFilter(): void {
    const edit = this.getView().getControl("assistantfield") as MulBasedataEdit;
    const orgId = this.getModel().getValue("useorg");

    edit.setQFilters([
      new QFilter("forbidstatus", "=", "A"),
      new QFilter("useorg.id", "=", orgId)
    ]);
    edit.setShowOnlyAudited(true);
  }
}

let plugin = new MultiAssistantFilterPlugin();
export { plugin };
```

## 注意事项

- 多选控件侧更适合做“可选范围控制”，结果结构解释仍要回到 `MulBasedataProp`。
- 如果问题是用户点击 F7 前的动态过滤，也可以配合事件拆分目录一起看。
