# ValidateResult

## 基本信息

- 名称: `ValidateResult`
- Java 类名: `kd.bos.entity.validate.ValidateResult`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/validate`
- 类型: 校验结果对象

## 用途概览

`ValidateResult` 用来汇总一次校验执行后的整体结果，包括是否成功、消息、校验器标识和错误集合。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `isSuccess()` / `setSuccess()` | 判断或设置校验结果 | 校验器返回结果 |
| `getMessage()` / `setMessage()` | 读写总体提示 | 汇总提示语 |
| `getAllErrorInfo()` / `addErrorInfo()` | 处理错误集合 | 聚合多条错误 |
| `getValidatorKey()` / `setValidatorKey()` | 标识校验器 | 多校验器链路 |

## 运行时注意事项

- 单条失败信息通常放在 `ValidationErrorInfo`，整体结果放在 `ValidateResult`。
- 如果你只塞了一条 message，没有补错误集合，复杂表单定位能力会弱很多。
- 某些链路下最终还会再被包装到 [OperationResult.md](OperationResult.md)。

## 常见搭配

- 校验错误: [ValidationErrorInfo.md](ValidationErrorInfo.md)
- 错误级别: [ErrorLevel.md](ErrorLevel.md)

## 关键词

- 中文: 校验结果, 校验器结果, 校验错误集合
- 英文: `ValidateResult`
