# 二开方案.表单插件.业务员字段实现组织隔离

        ## 适用场景

        业务员基础资料本身没有天然组织隔离，需要在表单插件里干预业务员 F7，只显示当前组织下允许选择的业务员。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/782280947445221376?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

        ## 核心思路

        1. 拦截业务员字段的 `beforeF7Select`。
2. 读取当前单据上的组织字段或上下文组织。
3. 把组织过滤条件塞给 F7 打开参数。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 组织字段示例：`saleorg`
- 业务员字段示例：`salesman`

        ## Kingscript 实现

        ```ts
        import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { BeforeF7SelectEvent } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class SalesmanOrgIsolationPlugin extends AbstractFormPlugin {

  beforeF7Select(e: BeforeF7SelectEvent): void {
    super.beforeF7Select(e);

    if (e.getProperty().getName() !== "salesman") {
      return;
    }

    const saleOrg = this.getModel().getValue("saleorg") as any;
    if (saleOrg == null) {
      return;
    }

    e.setCustomQFilters([
      new QFilter("kdec_saleorg.id", "=", saleOrg.get("id"))
    ]);
  }
}

let plugin = new SalesmanOrgIsolationPlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 确定业务员和组织在你们基础资料模型中的真实关联字段。
2. 在 `beforeF7Select` 中按组织拼过滤条件。
3. 必要时再叠加启用状态、权限状态等其他条件。

        ## 转写说明

        原文明确说这是一个方案型文章，示例代码也仅作思路参考。这里按 skill 的风格收敛成最常用的 F7 干预写法。

        ## 注意事项 / 风险点

        - 业务员资料和组织之间的真实字段路径因模型而异，`kdec_saleorg.id` 只是示例。
- 如果业务员可跨组织共享，还需要叠加更多判定逻辑，不能只按组织过滤。
- 没有组织值时要允许空走，否则会影响新增单据体验。

        风险等级：`需按实际元数据调整`

        ## 验证建议

        1. 切换不同组织后打开业务员 F7，确认候选范围会跟着变化。
2. 组织为空时测试一次，确认页面不会报错。
3. 如果有共享业务员，再补一组跨组织场景验证。

        ## 来源说明

        - L2 原文图片转写
- L4 本地资料校对
- L5 推断补全

        - 和基础资料联动控制、权限规则可以配合使用。
