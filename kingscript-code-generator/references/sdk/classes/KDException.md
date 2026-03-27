# KDException

## 基本信息

- 名称: `KDException`
- Java 类名: `kd.bos.exception.KDException`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/exception`
- 类型: 平台运行时异常

## 用途概览

`KDException` 是平台常见的运行时异常基类。很多服务端错误最终都会以它或它的子类形式抛出。

## 高频用法

| 方法 | 作用 |
|------|------|
| `getMessage()` | 取异常消息 |
| `getErrorCode()` | 取错误码 |
| `getStackTraceMessage()` | 取堆栈文本 |
| `getArgs()` | 取错误码参数 |

## 运行时注意事项

- 给用户提示时不要直接把完整堆栈原样透出。
- 如果只是业务校验失败，优先考虑 `ValidateResult` / `OperationResult`，不要动不动就抛异常。
- 真正排障时要同时看 error code、message 和 stack trace。

## 常见搭配

- 报错索引: [../indexes/error-index.md](../indexes/error-index.md)
- 操作结果: [OperationResult.md](OperationResult.md)

## 关键词

- 中文: 平台异常, 运行时异常, 错误码
- 英文: `KDException`
