# setWaterMarkInfo - 页面水印内容定制

## 基本信息

| 属性 | 说明 |
|------|------|
| 所属接口 | `AbstractFormPlugin` |
| 触发时机 | 页面准备设置水印信息时触发 |
| 方法签名 | `setWaterMarkInfo(e: any): void` |

## 说明

当页面启用了水印能力时，可以在 `setWaterMarkInfo` 中动态修改水印文本、时间、人员等展示信息，让截图、导出或预览时带上业务上下文。

## 业务场景

合同评审页面要求水印中同时显示当前登录人、组织和业务单号，方便截屏流转时追踪来源。

## 完整示例代码

```typescript
import { AbstractBillPlugIn } from "@cosmic/bos-core/kd/bos/bill";

class ContractWatermarkPlugin extends AbstractBillPlugIn {

  setWaterMarkInfo(e: any): void {
    super.setWaterMarkInfo(e);

    const billNo = this.getModel().getValue("billno") as string;
    const orgName = this.getModel().getValue("org") as string;
    const userName = this.getView().getContext().getCurrentUserName();

    e.setWaterMarkText("评审中");
    e.setWaterMarkSubText("用户:" + userName + " 组织:" + orgName);
    e.setWaterMarkFooter("单号:" + billNo);
  }
}

let plugin = new ContractWatermarkPlugin();
export { plugin };
```

## 注意事项

- 水印更适合轻量文本，不要在这里拼复杂 HTML。
- 文本内容要避免敏感字段直接暴露。
- 如果页面未启用水印能力，这个事件通常不是主要切入点。
