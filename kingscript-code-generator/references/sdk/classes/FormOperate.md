# FormOperate

## 基本信息

- 名称: `FormOperate`
- Java 类名: `kd.bos.form.operate.FormOperate`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/form/operate`
- 类型: 表单操作对象

## 用途概览

`FormOperate` 描述一次页面操作本身，比如当前操作 key、参数、焦点行、选中行和视图对象。很多 `beforeDoOperation`/`afterDoOperation` 问题都会回到它。

## 高频用法

| 方法 | 作用 |
|------|------|
| `getOperateKey()` | 识别当前是保存、提交还是审核 |
| `getOption()` / `setOption()` | 读写操作选项 |
| `getListSelectedData()` | 批量操作时取选中行 |
| `getView()` | 取当前视图对象 |
| `getParameter()` | 取自定义参数 |

## 运行时注意事项

- 它是“操作上下文”，不是最终执行结果。
- 如果你要看执行成败，还是要回到 [OperationResult.md](OperationResult.md)。
- 当前知识层统一以 `getOperateKey()` 作为已确认写法，不把 `getOperationKey()` 当作 `FormOperate` 的默认方法名。

## 常见搭配

- 操作结果: [OperationResult.md](OperationResult.md)
- 操作选项: [OperateOption.md](OperateOption.md)
- 表单前置事件: [BeforeDoOperationEventArgs.md](BeforeDoOperationEventArgs.md)

## 关键词

- 中文: 操作对象, 操作上下文, 操作 key
- 英文: `FormOperate`
