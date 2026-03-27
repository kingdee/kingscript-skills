# listFlexPack - 列表里补弹性域显示字段

## 适用场景

列表展示弹性域相关列时，在数据包输出前补显示文本，避免前端直接解析复杂对象。

## 核心对象

- `BeforePackageDataEvent`
- `DynamicObject`

## 完整示例代码

```typescript
import { AbstractListPlugIn } from "@cosmic/bos-core/kd/bos/list/plugin";
import { BeforePackageDataEvent } from "@cosmic/bos-core/kd/bos/entity/datamodel/events";

class FlexListPackPlugin extends AbstractListPlugIn {

  beforePackageData(e: BeforePackageDataEvent): void {
    super.beforePackageData(e);

    const dataEntitys = e.getDataEntitys();
    for (let i = 0; i < dataEntitys.length; i++) {
      const flexValue = dataEntitys[i].get("materialflex");
      if (flexValue != null) {
        dataEntitys[i].set("cust_materialflex_text", flexValue.get("name"));
      }
    }
  }
}

let plugin = new FlexListPackPlugin();
export { plugin };
```

## 注意事项

- 这种场景更适合在数据包阶段补“显示型字段”，而不是改底层业务字段。
- 如果问题发生在录入弹窗阶段，要回到 `FlexEdit` 看。
