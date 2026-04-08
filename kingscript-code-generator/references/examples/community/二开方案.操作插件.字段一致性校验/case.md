# 二开方案.操作插件.字段一致性校验

        ## 适用场景

        保存、提交、审核等操作前，需要校验当前单据中的多个字段值是否一致；不一致时阻止操作并给出明确信息。

        ## 原文链接

        - 社区原文: <https://vip.kingdee.com/knowledge/784422192502561280?specialId=570177930110532864&productLineId=40&isKnowledge=2&lang=zh-CN>

        ## 核心思路

        1. 操作插件里最稳的入口是 `onAddValidators(...)`。
2. 把一致性校验拆成自定义校验器，便于单独复用和测试。
3. 校验失败时返回明确的错误信息，而不是让后续流程报模糊异常。

## 原文截图

原文页面未提供可直接回填的正文截图，这篇案例以文字说明和 KS 代码为主。
        ## 实现前提

        - 操作插件挂到保存、提交或审核操作上
- 示例校验字段：单据体文本字段 `kdec_text`

        ## Kingscript 实现

        ```ts
        import { AbstractOperationServicePlugIn, AddValidatorsEventArgs } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { AbstractValidator, ValidationErrorInfo, ErrorLevel } from "@cosmic/bos-core/kd/bos/entity/validate";
import { DynamicObjectCollection, LocaleString } from "@cosmic/bos-core/kd/bos/dataentity/entity";

class FieldConsistencyOperationPlugin extends AbstractOperationServicePlugIn {

  onAddValidators(e: AddValidatorsEventArgs): void {
    super.onAddValidators(e);
    e.addValidator(new EntryTextConsistencyValidator());
  }
}

class EntryTextConsistencyValidator extends AbstractValidator {

  validate(): void {
    const extDataEntities = this.getDataEntities();
    for (let i = 0; i < extDataEntities.length; i++) {
      const extData = extDataEntities[i];
      const dataEntity = extData.getDataEntity();
      const entries = dataEntity.get("billentry") as DynamicObjectCollection;
      if (entries == null || entries.size() === 0) {
        continue;
      }

      const expected = String(entries.get(0).get("kdec_text"));
      for (let row = 1; row < entries.size(); row++) {
        const current = String(entries.get(row).get("kdec_text"));
        if (current !== expected) {
          const message = new LocaleString("分录字段 kdec_text 必须保持一致");
          this.getValidateResult().addErrorInfo(
            new ValidationErrorInfo(
              "kdec_text",
              extData.getBillPkId(),
              extData.getDataEntityIndex(),
              row,
              "KDEC_TEXT_NOT_EQUAL",
              this.getValidateContext().getOperateName(),
              message.toString(),
              ErrorLevel.Error
            )
          );
          return;
        }
      }
    }
  }
}

let plugin = new FieldConsistencyOperationPlugin();
export { plugin };
        ```

        ## 关键步骤说明

        1. 确定要校验的是表头字段、分录字段还是子分录字段。
2. 在 `onAddValidators(...)` 中注册自定义校验器。
3. 在校验器里遍历数据并输出清晰错误信息。

        ## 转写说明

        原文就是典型的方案型操作插件案例，最适合沉淀成一个可重复使用的自定义校验器模板。

        ## 注意事项 / 风险点

        - 不同版本里 `getDataEntities()` 返回结构可能略有差异，必要时可改用 `getValidDataEntities()` 一类项目既有封装。
- 这里只校验第一行与后续行一致；如果要做更复杂的成组一致性校验，需要继续扩展。
- 错误信息最好带上字段名或行号，方便最终用户定位问题。

        风险等级：`改字段标识后可用`

        ## 验证建议

        1. 准备一张分录字段全部一致的单据，确认操作可以通过。
2. 故意改动其中一行，再执行操作，确认会被阻止并给出提示。
3. 多张单据批量操作时，确认校验结果能准确定位到出错单据和行。

        ## 来源说明

        - L2 原文图片转写
- L4 本地资料校对
- L5 推断补全

        - 本地 examples 已覆盖 `onAddValidators` 和自定义 validator 的基本模式。
