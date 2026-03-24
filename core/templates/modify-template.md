# 代码修改模板

适用于“已有 Kingscript 脚本需要增量修改、修正行为、补充限制或做兼容性调整”的场景。

## 推荐输出结构

### 1. 修改目标

- 当前脚本要改什么
- 改动属于行为修正、性能优化、风险控制还是兼容性收口

### 2. 当前问题

- 现状是什么
- 为什么现状不满足需求
- 如果不改，会带来什么业务影响

### 3. 修改方案

- 说明改动点落在哪个插件类型、哪个事件或哪个判断分支
- 给出修改后的完整代码，或给出明确的替换片段

```ts
// 在这里放修改后的代码或 before/after 片段
```

### 4. 核心说明

- 为什么在这里改，而不是换别的事件
- 这次修改会不会影响已有联动逻辑
- 是否需要补充上下文判断或空值判断

### 5. 兼容性风险与回归点

- 是否影响旧逻辑、事件时机、返回值
- 是否影响权限、租户、账套、组织边界
- 需要重点回归哪些相邻场景

## 已填充示例

下面给出一个真实高频修改场景：已有脚本中所有字段值变更都会回传服务器，导致采购订单录单性能较差，现在需要只保留关键字段回传。

### 修改目标

把“字段一变就全部回传”的默认策略，调整为“只对数量、单价、物料、供应商、币别等关键联动字段保留回传；备注、描述、联系人等纯录入字段不回传”。

### 当前问题

- 当前脚本没有拦截 `beforeFieldPostBack`
- 用户录入备注、地址、联系人时，也会触发服务端回传
- 分录较多时，页面明显卡顿，录单体验差

### 修改方案

在单据插件中新增 `beforeFieldPostBack`，对纯文本录入字段调用 `e.setCancel(true)`，减少无意义的网络往返。

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class PmPurorderPostBackControlPlugin extends AbstractBillPlugIn {

  beforeFieldPostBack(e: any): void {
    super.beforeFieldPostBack(e);

    const fieldKey = e.getFieldKey();
    const skipPostBackFields = [
      "entryremark",
      "internalremark",
      "logisticsremark",
      "description",
      "headremark",
      "deliveryaddress",
      "contactperson",
      "contactphone"
    ];

    for (let i = 0; i < skipPostBackFields.length; i++) {
      if (fieldKey === skipPostBackFields[i]) {
        e.setCancel(true);
        return;
      }
    }
  }
}

let plugin = new PmPurorderPostBackControlPlugin();
export { plugin };
```

### 核心说明

- 选择 `beforeFieldPostBack`，因为这里是“客户端准备回传前”的最后拦截点
- 只拦截纯录入字段，不动数量、单价、物料、供应商、币别这些联动核心字段
- 这样既能保留服务端业务联动，又能减少不必要的请求

### 兼容性风险与回归点

- 如果某个备注类字段实际上挂了 `propertyChanged` 业务逻辑，就不能取消它的回传
- 需要回归验证数量、单价、物料、供应商、币别的联动计算是否仍然正常
- 需要回归验证保存时这些被拦截回传的字段是否仍能正确落库
