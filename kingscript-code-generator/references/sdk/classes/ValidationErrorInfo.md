# ValidationErrorInfo

## 基本信息

- 名称: `ValidationErrorInfo`
- Java 类名: `kd.bos.entity.validate.ValidationErrorInfo`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/validate`
- 类型: 校验错误信息

## 用途概览

`ValidationErrorInfo` 用来描述一条具体的校验失败信息，通常会包含提示消息、实体位置、字段位置、主键以及错误级别。

## 高频用法

| 方法 | 作用 | 典型场景 |
|------|------|------|
| `getMessage()` / `setMessage()` | 读写错误提示 | 给用户展示错误 |
| `getPkValue()` / `setPkValue()` | 关联具体对象 | 定位失败单据或行 |
| `setEntityKey()` | 指定实体 | 区分头/分录 |
| `setSubRowIndex()` | 指定分录行 | 精确定位某一行 |
| `getLevel()` / `setLevel()` | 处理错误级别 | 告警或错误分级 |

## 运行时注意事项

- 只写消息不写定位信息，前端经常只能看到提示，难以高亮到具体字段。
- 分录校验建议同时补实体 key 和行号。
- 如果你的需求是“聚合多条校验结果”，通常还要配合 [ValidateResult.md](ValidateResult.md) 或 `OperationResult`。

## 常见搭配

- 错误级别: [ErrorLevel.md](ErrorLevel.md)
- 校验结果: [ValidateResult.md](ValidateResult.md)

## 关键词

- 中文: 校验错误, 校验失败, 错误级别, 分录定位
- 英文: `ValidationErrorInfo`
