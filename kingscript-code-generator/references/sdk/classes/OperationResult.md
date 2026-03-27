# OperationResult

## 基本信息

- 名称: `OperationResult`
- Java 类名: `kd.bos.entity.operate.result.OperationResult`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/operate/result`
- 类型: 操作结果对象

## 用途概览

`OperationResult` 用来承载服务端操作执行后的结果信息，包括成功状态、成功主键、校验结果、错误信息和反馈消息。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `isSuccess()` | 判断是否成功 | 提交、审核、保存后判断 |
| `getMessage()` / `setMessage()` | 读写提示信息 | 反馈用户可读消息 |
| `getSuccessPkIds()` | 取成功单据主键 | 后续打开单据、回写 |
| `getAllErrorInfo()` | 取错误信息 | 聚合失败原因 |
| `getValidateResult()` | 取校验结果 | 和校验器联动 |
| `mergeOperateResult(...)` | 合并结果 | 批量或子流程汇总 |

## 运行时注意事项

- `isSuccess()` 不只是看有没有异常，也会受校验结果和错误信息影响。
- 批量操作时常常会出现“部分成功”，不要只看单一消息。
- 如果需要给前端更明确反馈，通常要同时处理 `message`、错误集合和成功主键。

## 常见搭配

- 表单操作对象: [FormOperate.md](FormOperate.md)
- 校验结果: [ValidateResult.md](ValidateResult.md)
- 校验错误: [ValidationErrorInfo.md](ValidationErrorInfo.md)

## 关键词

- 中文: 操作结果, 成功主键, 错误信息, 校验结果
- 英文: `OperationResult`
