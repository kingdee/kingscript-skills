# ErrorLevel

## 基本信息

- 名称: `ErrorLevel`
- Java 类名: `kd.bos.entity.validate.ErrorLevel`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/validate`
- 类型: 错误级别枚举

## 用途概览

`ErrorLevel` 用来标识校验或错误反馈的级别。它本身不负责展示逻辑，但会影响前端如何理解和处理这条校验结果。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `getValue()` | 取级别值 | 序列化或兼容处理 |
| `valueOf(int)` | 从数值取级别 | 反序列化或桥接 |
| `name()` / `toString()` | 输出枚举名 | 调试或日志 |

## 运行时注意事项

- 级别本身不等于是否拦截保存，要看具体校验器和结果承载对象怎么使用它。
- 如果只关心“能不能继续操作”，不要只盯着级别，仍要一起看 `ValidateResult` 或 `OperationResult`。

## 常见搭配

- 校验错误: [ValidationErrorInfo.md](ValidationErrorInfo.md)
- 校验结果: [ValidateResult.md](ValidateResult.md)

## 关键词

- 中文: 错误级别, 校验级别
- 英文: `ErrorLevel`
