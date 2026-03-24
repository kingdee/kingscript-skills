# 代码生成模板

适用于“需要生成一个新的 Kingscript 脚本或插件草稿”的场景。

## 推荐输出结构

### 1. 功能目标

- 这段脚本要解决什么业务问题
- 挂在哪种插件、哪个事件或哪个页面场景

### 2. 前置假设

- 当前插件基类
- 关键字段标识
- 当前上下文对象是否可用
- 依赖的开放 SDK 或服务能力
- 权限、租户、账套、组织等前提

### 3. 代码实现

```ts
// 在这里放完整 Kingscript 代码
```

### 4. 核心说明

- 为什么选这个插件基类
- 为什么放在这个事件里
- 关键判断和调用的原因

### 5. 风险与待确认项

- 哪些 API 还没有最终确认
- 哪些字段名、实体名、权限前提依赖外部环境
- 哪些地方要回归验证

## 已填充示例

下面给出一个可直接参考的生成示例，目标是：在采购订单中，已审核单据不允许修改单价。

### 功能目标

在采购订单单据插件里拦截 `price` 字段修改。如果单据已审核，则阻止修改；如果录入的新单价为负数，也直接拦截。

### 前置假设

- 当前场景是单据插件，基类使用 `AbstractBillPlugIn`
- 审核状态字段为 `billstatus`
- 单价字段标识为 `price`
- 已审核状态值为 `C`
- 运行时支持 `BigDecimal`

### 代码实现

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class PmPurorderPriceCheckPlugin extends AbstractBillPlugIn {

  beforePropertyChanged(e: any): void {
    super.beforePropertyChanged(e);

    const fieldKey = e.getPropertyName();
    if (fieldKey !== "price") {
      return;
    }

    const billStatus = this.getModel().getValue("billstatus") as string;
    if (billStatus === "C") {
      e.setCancel(true);
      this.getView().showWarnNotification("已审核的采购订单不允许修改单价");
      return;
    }

    const newPrice = e.getNewValue() as BigDecimal;
    if (newPrice != null && newPrice.compareTo(BigDecimal.ZERO) < 0) {
      e.setCancel(true);
      this.getView().showWarnNotification("单价不能为负数");
    }
  }
}

let plugin = new PmPurorderPriceCheckPlugin();
export { plugin };
```

### 核心说明

- 使用 `AbstractBillPlugIn`，因为采购订单属于单据场景
- 使用 `beforePropertyChanged`，因为这里需要“写入前拦截”
- 审核状态和负数校验都属于前置校验，适合直接 `setCancel(true)`

### 风险与待确认项

- `billstatus`、`price` 的字段标识需要与你的单据模型一致
- 如果项目里审核状态枚举不是 `C`，需要按实际值调整
- 若当前环境没有 `BigDecimal` 运行时支持，需要改用实际可用的数值类型方案
