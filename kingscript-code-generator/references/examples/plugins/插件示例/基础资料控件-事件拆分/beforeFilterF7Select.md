# beforeFilterF7Select - F7 过滤条件二次加工

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | F7 打开前，系统准备最终过滤条件时触发 |
| 方法签名 | `beforeFilterF7Select(e: BeforeFilterF7SelectEvent): void` |

## 说明

`beforeFilterF7Select` 适合在标准过滤条件基础上继续追加细粒度限制，常用于多组织、多业务线或按上游字段联动过滤。

## 业务场景

费用承担部门只能从当前组织下、且与当前项目归属匹配的部门中选择。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BeforeFilterF7SelectEvent } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class ExpenseDeptFilterPlugin extends AbstractBillPlugIn {

  beforeFilterF7Select(e: BeforeFilterF7SelectEvent): void {
    super.beforeFilterF7Select(e);

    if (e.getFieldKey() !== "expensedept") {
      return;
    }

    const orgId = this.getModel().getValue("org");
    const projectId = this.getModel().getValue("project");

    e.addQFilter(new QFilter("useorg.id", "=", orgId));

    if (projectId != null) {
      e.addQFilter(new QFilter("project.id", "=", projectId));
    }
  }
}

let plugin = new ExpenseDeptFilterPlugin();
export { plugin };
```

## 注意事项

- 这个事件通常是在已有过滤条件之上继续补充，不建议把已有条件全部覆盖掉。
- 需要区分字段 key 和属性名时，优先按实际事件参数判断。
- 多个过滤条件叠加后要关注是否会导致“无数据可选”。
