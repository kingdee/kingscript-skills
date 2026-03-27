# AbstractWriteBackPlugIn

## 基本信息

- 名称: `AbstractWriteBackPlugIn`
- Java 类名: `kd.bos.entity.botp.plugin.AbstractWriteBackPlugIn`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/botp/plugin`
- 类型: 反写插件基类

## 用途概览

`AbstractWriteBackPlugIn` 用于目标单对源单的回写链路，比如回写数量、关闭行、超额检查和保存前后的拦截。

## 高频事件

| 方法 | 作用 |
|------|------|
| `beforeReadSourceBill` | 回写前补源单字段 |
| `preparePropertys` | 补目标单需要读取的字段 |
| `afterCommitAmount` | 回写数量后再调整 |
| `beforeSaveTrans` | 事务保存前准备外部数据 |

## 运行时注意事项

- 它解决的是“回写”，不是“转换”。很多下推问题要把两者分开看。
- 回写通常牵涉源单状态、超额校验和事务边界，出问题时不要只看页面日志。

## 常见搭配

- 转换插件: [AbstractConvertPlugIn.md](AbstractConvertPlugIn.md)
- 操作结果: [OperationResult.md](OperationResult.md)

## 关键词

- 中文: 反写插件, 回写规则, 回写数量
- 英文: `AbstractWriteBackPlugIn`
