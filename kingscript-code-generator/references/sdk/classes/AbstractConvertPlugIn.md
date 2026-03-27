# AbstractConvertPlugIn

## 基本信息

- 名称: `AbstractConvertPlugIn`
- Java 类名: `kd.bos.entity.botp.plugin.AbstractConvertPlugIn`
- 模块: `@cosmic/bos-core`
- 所属包: `kd/bos/entity/botp/plugin`
- 类型: 单据转换插件基类

## 用途概览

`AbstractConvertPlugIn` 用于单据下推、转换规则扩展和目标单字段补写。凡是“源单到目标单”的链路，通常都要先确认是不是它在起作用。

## 高频事件

| 方法 | 作用 |
|------|------|
| `beforeGetSourceData` | 调整取源数据 |
| `afterFieldMapping` | 字段映射后补值 |
| `afterConvert` | 转换末尾统一收口 |
| `beforeBuildRowCondition` | 控制行筛选条件 |

## 运行时注意事项

- 它处理的是转换规则，不是普通页面事件。
- 复杂下推问题常常还要一起看操作插件、反写插件和 `OperateOption`。

## 常见搭配

- 反写插件: [AbstractWriteBackPlugIn.md](AbstractWriteBackPlugIn.md)
- 操作选项: [OperateOption.md](OperateOption.md)

## 关键词

- 中文: 转换插件, 下推插件, 转换规则
- 英文: `AbstractConvertPlugIn`
