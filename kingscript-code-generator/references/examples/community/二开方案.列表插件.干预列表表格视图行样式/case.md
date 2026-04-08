# 二开方案.列表插件.干预列表表格视图行样式

        ## 适用场景

        列表界面的样式规则不足以覆盖复杂业务条件时，可以在插件里先算出哪些行需要高亮，再结合实际列表样式 API 做干预。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/784054865240021504?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

        ## 核心思路

        1. 先把“哪一行要高亮、用什么颜色高亮”这件事抽成纯逻辑判断。
2. 列表插件只负责读取行数据并把判断结果交给样式层。
3. 这样即使不同项目的样式 API 不完全一致，核心规则也能稳定复用。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 示例判断条件：创建日期早于今天的单据高亮显示
- 需要你在本地项目里把颜色规则接到真实列表样式 API

        ## Kingscript 实现

        ```ts
        import { AbstractListPlugin } from "@cosmic/bos-core/kd/bos/list/plugin";
import { AfterBindDataEvent } from "@cosmic/bos-core/kd/bos/form/events";

class ListRowStylePlugin extends AbstractListPlugin {

  afterBindData(e: AfterBindDataEvent): void {
    super.afterBindData(e);

    const rows = this.getModel().getDataEntity(true) as any[];
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    for (let rowIndex = 0; rowIndex < rows.length; rowIndex++) {
      const row = rows[rowIndex];
      const createDate = new Date(row.get("createdate"));
      if (createDate.getTime() < today.getTime()) {
        // 这里保留规则判断，实际项目里把颜色接到本地列表样式 API。
        // 例如：setRowStyle / setCellStyle / setBackColor 等。
      }
    }
  }
}

let plugin = new ListRowStylePlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 先写清楚样式判定条件，不要一开始就埋进颜色 API。
2. 在数据绑定后遍历行数据，得到待高亮的行。
3. 最后再按项目已有能力把颜色、字体或图标规则真正渲染出来。

        ## 转写说明

        原文是“干预列表表格视图行样式”的方案型文章。这里保留最稳的规则判定骨架，并明确把最终样式落地交给项目中的真实列表 API。

        ## 注意事项 / 风险点

        - 不同列表控件、不同版本的样式 API 差异较大，这里没有硬写具体调用，避免伪造接口。
- 如果要按单元格高亮而不是整行高亮，需要把规则拆到列粒度。
- 行数据来源如果不是 `getDataEntity(true)`，要换成项目当前列表的数据读取方式。

        风险等级：`推断版，建议先验证`

        ## 验证建议

        1. 先打印或断点确认哪些行命中了高亮规则。
2. 接上项目真实样式 API 后，再验证界面颜色是否正确。
3. 切换日期边界值，确认当天与历史单据的样式区分符合预期。

        ## 来源说明

        - L2 原文图片转写
- L4 本地资料校对
- L5 推断补全

        - 这篇案例更适合当“规则骨架 + 本地样式接线提示”来用。
