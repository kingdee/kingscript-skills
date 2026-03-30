# 操作插件-场景拆分

这个目录聚焦服务端操作插件里的完整业务套路，优先覆盖预加载字段、挂校验器、事务前校验和中断操作。

## 场景目录

- [prepareFieldsAndAddValidator.md](prepareFieldsAndAddValidator.md)
- [cancelOperationBeforeTransaction.md](cancelOperationBeforeTransaction.md)

## 使用建议

- 当问题是“操作插件需要先补哪些字段”“怎么在服务端挂校验器或事务前阻断”时，先看这里。
- 如果你已经明确知道事件名，再回到 [操作插件-事件拆分](../操作插件-事件拆分/README.md) 查单事件写法。
