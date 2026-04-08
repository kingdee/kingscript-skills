# 二开方案.表单插件.基础资料根据前置条件匹配过滤条件

        ## 适用场景

        基础资料字段无法仅靠配置实现“按前置条件匹配不同过滤条件”，需要在 F7 打开前动态判断前置字段，再设置不同的过滤表达式。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/783345969277650944?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

        ## 核心思路

        1. 前置条件通常是单据类型、业务组织、业务场景等字段。
2. 在 `beforeF7Select` 里先读取前置条件，再决定拼哪一组过滤。
3. 这种写法很适合替代企业版里的高级过滤联动。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 前置字段示例：`billtype`
- 目标基础资料字段示例：`material`

        ## Kingscript 实现

        ```ts
        import { AbstractFormPlugin } from "@cosmic/bos-core/kd/bos/form/plugin";
import { BeforeF7SelectEvent } from "@cosmic/bos-core/kd/bos/form/field/events";
import { QFilter } from "@cosmic/bos-core/kd/bos/orm/query";

class MaterialFilterByBillTypePlugin extends AbstractFormPlugin {

  beforeF7Select(e: BeforeF7SelectEvent): void {
    super.beforeF7Select(e);

    if (e.getProperty().getName() !== "material") {
      return;
    }

    const billType = this.getModel().getValue("billtype") as any;
    if (billType == null) {
      return;
    }

    const typeNumber = String(billType.get("number"));
    if (typeNumber === "RETURN") {
      e.setCustomQFilters([new QFilter("kdec_materialtype", "=", "RETURN_ONLY")]);
    } else {
      e.setCustomQFilters([new QFilter("forbidstatus", "=", "A")]);
    }
  }
}

let plugin = new MaterialFilterByBillTypePlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 先列清楚“前置条件值 -> 过滤条件”的映射表。
2. 进入 `beforeF7Select` 后只处理目标字段，避免误伤页面上的其他 F7。
3. 按不同前置值设置不同过滤数组。

        ## 转写说明

        原文强调的是“根据前置条件匹配过滤条件”的思路，这里用单据类型控制物料过滤做了一个最容易套用的 KS 模板。

        ## 注意事项 / 风险点

        - 真实项目里前置条件可能不止一个字段，建议抽成单独的过滤构造方法。
- 如果字段值是基础资料对象，不要直接把对象转字符串，需要明确取编号还是主键。
- 过滤条件字段名必须对应基础资料模型字段，而不是页面控件 key。

        风险等级：`需按实际元数据调整`

        ## 验证建议

        1. 切换不同单据类型后打开同一个物料 F7，确认候选范围不同。
2. 前置字段为空时测试一次，确认不会报错。
3. 叠加已有固定过滤时，确认结果符合预期。

        ## 来源说明

        - L2 原文图片转写
- L4 本地资料校对
- L5 推断补全

        - 本质上是 `beforeF7Select` 的条件分支模板。
