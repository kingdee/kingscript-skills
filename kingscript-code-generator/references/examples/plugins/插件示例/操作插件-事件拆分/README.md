# 操作插件 - 事件拆分

本目录聚焦服务端操作插件最常见的 4 类入口，优先覆盖“保存/提交/审核前先补字段”“事务前后做处理”“拿到执行结果怎么收口”。

## 事件目录

- [onPreparePropertys.md](onPreparePropertys.md)
- [beginOperationTransaction.md](beginOperationTransaction.md)
- [beforeExecuteOperationTransaction.md](beforeExecuteOperationTransaction.md)
- [afterExecuteOperationTransaction.md](afterExecuteOperationTransaction.md)

## 使用建议

- 只是补加载字段时，先看 `onPreparePropertys`
- 需要在事务里批量改值时，先看 `beginOperationTransaction`
- 需要执行前做最终拦截或准备时，先看 `beforeExecuteOperationTransaction`
- 需要根据结果收口或记录反馈时，先看 `afterExecuteOperationTransaction`
