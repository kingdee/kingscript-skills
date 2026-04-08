# prepareFieldsAndAddValidator - 预加载字段并挂校验器

## 场景

服务端操作插件要做批量校验时，先在 `onPreparePropertys` 里补齐后续会用到的字段，再在 `onAddValidators` 里挂一个自定义校验器，把真正的业务规则收敛到校验器内部。

## Java 来源

- `kd.bos.plugin.sample.bill.bizoperation.bizcase.OnAddValidatorsSample`

这个 Java 样例的核心不是复杂逻辑，而是先声明需要加载哪些字段，再把校验器接入操作链路。

## 适用入口

- `onPreparePropertys(e: PreparePropertysEventArgs): void`
- `onAddValidators(e: AddValidatorsEventArgs): void`
- 校验器基类：`AbstractValidator`
- 插件基类：`AbstractOperationServicePlugIn`

## 完整 Kingscript 示例

```typescript
import { AbstractOperationServicePlugIn, PreparePropertysEventArgs, AddValidatorsEventArgs } from "@cosmic/bos-core/kd/bos/entity/plugin";
import { AbstractValidator, ErrorLevel, ValidationErrorInfo } from "@cosmic/bos-core/kd/bos/entity/validate";

class DeliveryDateValidator extends AbstractValidator {
  validate(): void {
    let extDataEntities = this.getDataEntities();

    for (let rowExtData of extDataEntities) {
      let dataEntity = rowExtData.getDataEntity();
      let deliveryDate = dataEntity.get("deliverydate") as Date;
      let lastDate = dataEntity.get("lastdate") as Date;

      if (deliveryDate == null || lastDate == null) {
        continue;
      }

      if (deliveryDate.getTime() > lastDate.getTime()) {
        let info = new ValidationErrorInfo(
          "",
          rowExtData.getBillPkId(),
          rowExtData.getDataEntityIndex(),
          rowExtData.getRowIndex(),
          "DELIVERY_DATE_INVALID",
          this.getValidateContext().getOperateName(),
          "预计送货日期不能晚于最迟送货日期。",
          ErrorLevel.Error
        );
        this.getValidateResult().addErrorInfo(info);
      }
    }
  }
}

class PrepareFieldsAndValidatorScenePlugin extends AbstractOperationServicePlugIn {

  onPreparePropertys(e: PreparePropertysEventArgs): void {
    super.onPreparePropertys(e);

    let fieldKeys = e.getFieldKeys();
    fieldKeys.add("deliverydate");
    fieldKeys.add("lastdate");
    fieldKeys.add("billno");
  }

  onAddValidators(e: AddValidatorsEventArgs): void {
    super.onAddValidators(e);
    e.addValidator(new DeliveryDateValidator());
  }
}

let plugin = new PrepareFieldsAndValidatorScenePlugin();
export { plugin };
```

## 映射说明

- Java 样例里 `onPreparePropertys` 只做一件事：把后续校验一定会访问的字段提前加到 `fieldKeys` 中；这里完全保留这个职责边界。
- Java 样例在 `onAddValidators` 中 `addValidator(new DelivaryDateValidator())`，Kingscript 也适合按这个结构拆成“插件负责注册、校验器负责验证”。
- 校验器里的 `ValidationErrorInfo` 写法参考了仓库现有操作插件示例，这样既能保留 Java 的批量校验思路，也更贴近当前 examples 的已知能力。

## 注意事项

- 如果校验器里要访问的字段没有在 `onPreparePropertys` 里预加载，运行时很容易出现取不到值的情况。
- 校验器更适合做“阻断型规则”，不适合承载页面交互或消息提示。
- 批量操作时不要只校验第一张单据，应该按 `extDataEntities` 全量遍历并收集错误。
- 当规则足够独立时，优先放进校验器；只有必须依赖操作流程本身的逻辑，再考虑放到事务前后事件里。
