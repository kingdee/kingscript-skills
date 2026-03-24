# AbstractValidator

## 基本信息

- 名称：`AbstractValidator`
- Java 类名：`kd.bos.entity.validate.AbstractValidator`
- TS 导出名：`AbstractValidator`
- 所属模块：`@cosmic/bos-core`
- 所属包：`kd/bos/entity`
- 命名空间：`kd.bos.entity.validate`
- 类型：操作校验器基类
- 来源：
  - TS 声明：`@cosmic/bos-core/kd/bos/entity/validate.d.ts`
  - 相关示例：[操作插件.md](../../examples/plugins/插件示例/操作插件.md)
  - 相关说明：[AbstractOperationServicePlugIn.md](AbstractOperationServicePlugIn.md)
  - Javadoc：待补充

## 用途概述

用于定义操作执行前的自定义校验逻辑，常通过 `AbstractOperationServicePlugIn` 的 `onAddValidators` 注入到操作链路中。

## 典型场景

- 提交前校验分录不能为空
- 审核前校验数量、金额、状态是否合法
- 批量操作时，对每张单据分别生成校验错误信息
- 在标准校验器之后追加业务特有规则

## 用户常见问法

- 自定义校验器怎么写
- 保存/提交/审核前怎么加批量校验
- 校验失败怎么返回错误信息
- `onAddValidators` 里应该加什么

## 常见搭配

- `AbstractOperationServicePlugIn`
  - 在 `onAddValidators` 中注册自定义校验器
- `ValidationErrorInfo`
  - 用于构造校验失败信息
- `ErrorLevel`
  - 用于标记错误级别
- `ValidateResult`
  - 用于收集校验结果
- `ValidateContext`
  - 用于获取当前校验上下文

## 高价值规则

- `AbstractValidator` 通常不单独使用，而是和操作插件配套
- 校验器更适合做“阻断型规则”，不适合写页面交互逻辑
- 批量操作时要按“多单据、多分录”思维写校验，不要只处理第一条数据
- 一条校验失败不代表其他单据不能继续被检查，建议尽量收集完整错误

## 典型接入方式

### 场景：在操作插件里注册校验器

```kingscript
onAddValidators(e: AddValidatorsEventArgs): void {
    super.onAddValidators(e);
    e.addValidator(new ReqEntryValidator());
}
```

### 场景：在校验器里收集错误

```kingscript
class ReqEntryValidator extends AbstractValidator {
    validate(): void {
        let extDataEntities = this.getDataEntities();
        for (let rowExtData of extDataEntities) {
            // 业务校验
            // 失败时通过 this.getValidateResult().addErrorInfo(info) 收集错误
        }
    }
}
```

## 运行时注意事项

- 它位于操作服务侧，不是表单插件侧
- 校验器执行时机在事务正式执行前，适合做阻断型验证
- 校验错误通常需要构造成平台可识别的错误信息对象，而不是只 `throw` 字符串
- 如果校验依赖字段值，要先确认操作插件里是否在 `onPreparePropertys` 预加载了相关字段

## 常见错误

### 1. 校验器写了但拿不到字段

高概率原因：
- 操作插件没有在 `onPreparePropertys` 中预加载需要的字段

### 2. 校验逻辑执行了，但错误没有正确反馈

高概率原因：
- 没有把错误写入 `ValidateResult`
- 只做了日志输出，没有构造 `ValidationErrorInfo`

### 3. 把页面交互逻辑写进校验器

高概率原因：
- 混淆了操作校验和表单交互的职责边界

## 相关文档

- [AbstractOperationServicePlugIn.md](AbstractOperationServicePlugIn.md)
- [操作插件.md](../../examples/plugins/插件示例/操作插件.md)
- troubleshooting.md

## 关键词

- 中文关键词：校验器、自定义校验器、操作校验、提交前校验、审核前校验
- 英文关键词：`AbstractValidator`、validator
- 常见报错词：取不到字段、校验不生效、错误信息未返回
