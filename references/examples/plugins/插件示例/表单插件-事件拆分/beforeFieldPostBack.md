# beforeFieldPostBack - 客户端字段值变动回传事件

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | AbstractFormPlugin |
| 触发时机 | 客户端字段值发生变动准备回传服务器之前触发，可在此拦截不必要的回传请求 |
| 方法签名 | `beforeFieldPostBack(e: any): void` |

## 说明

当客户端（浏览器端）字段值发生变动，准备将变更回传到服务器端之前触发的事件回调。通过该方法可以控制哪些字段的值变更需要回传服务器处理，哪些不需要。对于不需要服务端处理的字段值变更，可以取消回传以减少网络请求，提升界面操作性能。

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| e | any | 事件参数对象 |
| e.getFieldKey() | string | 获取发生变动的字段标识 |
| e.setCancel(boolean) | void | 设置为 true 可取消本次回传，字段值变更不会发送到服务器 |

## 业务场景

采购订单中有多个文本类备注字段（如行备注、内部备注、物流备注），这些字段的值变更不需要触发服务端联动计算。通过拦截这些字段的回传请求，减少不必要的网络交互，提高用户录单效率。同时保留关键字段（如数量、单价、物料）的回传，确保联动计算正常触发。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

/**
 * 采购订单表单插件 - 控制字段值变更回传策略以提升性能
 */
class PmPurorderPostBackControlPlugin extends AbstractBillPlugIn {

  beforeFieldPostBack(e: any): void {
    super.beforeFieldPostBack(e);

    const fieldKey = e.getFieldKey();

    // 定义不需要回传服务器的字段列表
    // 这些字段的值变更不涉及服务端联动计算
    const skipPostBackFields = [
      "entryremark",       // 行备注
      "internalremark",    // 内部备注
      "logisticsremark",   // 物流备注
      "description",       // 描述信息
      "headremark",        // 单据头备注
      "deliveryaddress",   // 收货地址（纯文本）
      "contactperson",     // 联系人
      "contactphone"       // 联系电话
    ];

    // 判断当前变动字段是否在跳过列表中
    for (let i = 0; i < skipPostBackFields.length; i++) {
      if (fieldKey === skipPostBackFields[i]) {
        // 取消回传，减少不必要的服务端请求
        e.setCancel(true);
        return;
      }
    }

    // 以下字段值变更需要正常回传服务器（默认行为，无需额外处理）：
    // - qty（数量）：触发金额联动计算
    // - price（单价）：触发金额联动计算
    // - material（物料）：触发带出物料属性
    // - supplier（供应商）：触发带出供应商信息
    // - currency（币别）：触发汇率联动
  }
}

let plugin = new PmPurorderPostBackControlPlugin();
export { plugin };
```

## 注意事项

- 必须调用 `super.beforeFieldPostBack(e)` 以确保父类逻辑正常执行
- `e.setCancel(true)` 取消回传后，服务端的 `propertyChanged` 等事件将不会针对该字段触发
- 只应对纯展示或纯录入字段（如备注、描述）取消回传，不要对参与联动计算的字段取消
- 取消回传不影响字段值的最终保存，保存操作时所有字段值仍会完整提交到服务器
- 在分录行较多、字段较多的单据中，合理使用此方法可以显著提升录单效率
- 如果某个字段的 `propertyChanged` 事件中有重要业务逻辑，不应取消该字段的回传
- 插件类不能定义类属性，所有变量应在方法内部声明为局部变量
