# registerListener - 注册控件监听器事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 表单初始化阶段，控件创建完成后触发，用于注册各类控件事件监听器 |
| 方法签名 | `registerListener(e: $.java.util.EventObject): void` |

## 说明

注册控件监听器的回调事件，是表单插件中最核心的方法之一。在表单初始化阶段，控件创建完成后触发此方法，插件可在此注册各种控件的事件监听器，包括基础资料F7过滤监听、工具栏按钮点击监听、分录行点击监听等。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | $.java.util.EventObject | 事件参数对象（EventObject） |

## 业务场景

注册多个基础资料F7过滤监听、工具栏按钮点击监听。在采购订单中，物料字段需要根据当前组织过滤，自定义工具栏按钮需要响应点击事件。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";
import { BasedataEdit } from "@cosmic/bos-core/kd/bos/form/field";
import { BeforeF7SelectEvent, BeforeF7SelectListener } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

/**
 * 采购订单插件 - 注册F7过滤、按钮点击、分录行点击等多种监听器
 */
class PmPurorderListenerPlugin extends AbstractBillPlugIn implements BeforeF7SelectListener  {

  registerListener(e: $.java.util.EventObject): void {
    super.registerListener(e);

    // 1. 注册物料字段的F7过滤监听
    const materialEdit = this.getControl("material") as BasedataEdit;
    if (materialEdit != null) {
      materialEdit.addBeforeF7SelectListener(this);
    }

    // 2. 注册供应商字段的F7过滤监听
    const supplierEdit = this.getControl("supplier") as BasedataEdit;
    if (supplierEdit != null) {
      supplierEdit.addBeforeF7SelectListener(this);
    }

    // 3. 注册工具栏按钮点击监听
    this.addItemClickListeners("adv_toolbarap");
  }

  // F7过滤事件处理
  beforeF7Select(e: BeforeF7SelectEvent): void {
    const fieldKey = e.getProperty().getName();
    const orgId = this.getModel().getValue("org_id");

    if (fieldKey === "material") {
      // 物料按当前采购组织过滤，且只显示启用状态的物料
      const orgFilter = new QFilter("useorgid", "=", orgId);
      const statusFilter = new QFilter("status", "=", "C");
      e.getCustomQFilters().add(orgFilter);
      e.getCustomQFilters().add(statusFilter);
    }

    if (fieldKey === "supplier") {
      // 供应商按当前组织过滤，且只显示已审核的供应商
      const orgFilter = new QFilter("entry_org", "=", orgId);
      const statusFilter = new QFilter("status", "=", "C");
      e.getCustomQFilters().add(orgFilter);
      e.getCustomQFilters().add(statusFilter);
    }
  }
}

let plugin = new PmPurorderListenerPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.registerListener(e)` 以确保父类的监听器注册逻辑正常执行
- `registerListener` 是注册所有控件监听器的统一入口，应将所有监听注册集中在此方法中
- 注册F7过滤监听前需先通过 `getControl()` 获取控件实例，并判断是否为 null
- 工具栏按钮点击监听通过 `addItemClickListeners(...)` 注册，参数是工具栏控件标识，不是 `evt.getItemKey()` 里的按钮 key
- 分录行点击监听应通过 `getControl<EntryGrid>(...)` 后调用 `addRowClickListener(this)` 注册，而不是编造 `addClickService(...)`
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
- 监听注册应在此方法中完成，不要在其他生命周期方法中重复注册
